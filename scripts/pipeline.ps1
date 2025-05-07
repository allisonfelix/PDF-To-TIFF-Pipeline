# --- Configurações ---
$tratamentoRoot = 'D:\GS Teste\Tratamento'
$destRoot       = 'D:\GS Teste\Pedidos'
$iccProfileCMYK = 'D:\GS Teste\PerfisICC\USWebCoatedSWOP.icc'
$dpi            = 300

# Garante pastas
if (!(Test-Path $tratamentoRoot)) { New-Item -ItemType Directory -Path $tratamentoRoot -Force }
if (!(Test-Path $destRoot))       { New-Item -ItemType Directory -Path $destRoot -Force }

# 1) Processamento paralelo com Jobs
$jobs = @()
Get-ChildItem -Path $tratamentoRoot -Recurse -File | ForEach-Object {
    $jobs += Start-Job -ScriptBlock {
        param($file, $folder, $baseName, $dpi, $iccProfileCMYK)
        
        $ext = [System.IO.Path]::GetExtension($file).ToLower()
        $length = (Get-Item $file).Length

        if ($length -eq 0) {
            Write-Host "Pulando zero-byte: $file"
            return
        }

        if ($ext -eq '.pdf') {
            try {
                $pageCount = (& magick identify "$file" | Measure-Object).Count
                
                magick -density $dpi -colorspace CMYK -units PixelsPerInch "$file" `
                    -background none `
                    -alpha set `
                    -profile "$iccProfileCMYK" `
                    -intent Perceptual `
                    -define tiff:alpha=associated `
                    -compress LZW `
                    "$folder\$baseName-%03d.tif"

                $tiffs = Get-ChildItem "$folder\$baseName-*.tif" | Where-Object { $_.Length -gt 0 }
                if ($tiffs.Count -eq $pageCount) {
                    Write-Host "Conversão OK: $baseName."
                    # Remove-Item $file -Force
                }
            }
            catch {
                Write-Warning "Erro em $file : $_"
            }
        }
    } -ArgumentList $_.FullName, $_.DirectoryName, $_.BaseName, $dpi, $iccProfileCMYK
}

# Aguarda conclusão de todos os jobs
$jobs | Receive-Job -Wait -AutoRemoveJob

# 2) Movimentação com tratamento de erros
Get-ChildItem -Path $tratamentoRoot -Directory | ForEach-Object {
    $src = $_.FullName
    $dst = Join-Path $destRoot $_.Name

    try {
        if (Test-Path $dst) {
            robocopy $src $dst /E /MOVE /R:3 /W:5 | Out-Null
            Remove-Item $src -Recurse -Force -ErrorAction Stop
            Write-Host "Mesclado: $src → $dst"
        } else {
            Move-Item -Path $src -Destination $dst -Force -ErrorAction Stop
            Write-Host "Movido: $src → $dst"
        }
    }
    catch {
        Write-Warning "Falha ao mover $src : $_"
    }
}