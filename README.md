
# 🖨️ PDF-to-TIFF Pipeline Automator – PowerShell + ImageMagick

Este projeto automatiza o processo de conversão de arquivos PDF enviados por clientes em imagens TIFF de alta qualidade para uso em ambientes gráficos industriais. Utiliza **PowerShell** para orquestração e **ImageMagick** para o preflight e rasterização das páginas, além de aplicar perfis de cor ICC e mover os arquivos para o local de produção.

🔧 Desenvolvido para a realidade de uma **gráfica B2B** com alto volume diário de arquivos, o pipeline substitui etapas manuais que antes exigiam a abertura individual de páginas no Photoshop.

---

## 🧩 Contexto do Problema

Na **Graficonauta**, operávamos com um fluxo ineficiente onde operadores de pré-impressão precisavam:
- Abrir **manualmente PDFs página a página no Photoshop**;
- Exportar cada página como TIFF com ajustes manuais de DPI e perfil CMYK;
- Criar pastas e mover os arquivos manualmente para o fluxo de produção.

🚫 Isso consumia entre **5 a 10 minutos por arquivo** e gerava retrabalho, atrasos e inconsistências.

---

## ✅ Solução

O pipeline atual faz:

1. **Varredura automática** em uma pasta de pré-tratamento (para onde o servidor baixa os arquivos de pedidos do site);
2. **Processamento paralelo** de todos os PDFs com múltiplas páginas;
3. **Conversão TIFF em lote** com perfil de cor ICC, compressão LZW e resolução profissional (300 DPI);
4. **Validação da conversão** com verificação de quantidade de páginas e arquivos TIFF;
5. **Movimentação estruturada** das pastas para o setor de produção.

---

## 📂 Estrutura do Projeto

```
PDF-to-TIFF-Pipeline/
├── scripts/
│   └── pipeline.ps1           # Script principal em PowerShell
├── PerfisICC/
│   └── USWebCoatedSWOP.icc    # Perfil CMYK utilizado
├── Tratamento/                # Pasta de entrada de arquivos PDF
├── Pedidos/                   # Pasta de saída com os arquivos prontos
├── README.md
```

---

## ⚙️ Tecnologias Utilizadas

- **PowerShell 5+**
- **ImageMagick (convert / magick)**
- **robocopy** (Windows CLI)
- **Perfis ICC para controle de cor**
- **Ambiente Windows 10/11 corporativo**

---

## 🧾 Por que não Acrobat Pro ou Photoshop?

Embora o **Adobe Acrobat Pro** permita a exportação de PDFs em imagens (inclusive TIFFs), essa funcionalidade:

- ⚠️ **Requer acionamento manual** e configuração de cada exportação;
- 🖱️ Demanda interação do operador, aumentando o tempo por arquivo;
- 💸 Depende de uma **licença paga** do Acrobat Pro, que não está disponível em todos os computadores da empresa.

Da mesma forma, scripts em **Photoshop (ExtendScript/JSX)** requerem que os arquivos estejam abertos manualmente, e perdem referência de caminho dentro do script ao lidar com arquivos PDF — o que torna a automação menos robusta.

🎯 A solução com PowerShell + ImageMagick executa de forma **autônoma, paralela e escalável**, sendo ideal para ambientes com alto volume e computadores com licenças variadas.

---

## 📈 Impacto Real

- ⏱️ Redução média de **90% no tempo de preparação** de arquivos PDF com múltiplas páginas.
- ⚙️ Pipeline robusto e escalável para milhares de arquivos por semana.
- 🔐 Prevenção de falhas com validações de arquivos corrompidos e zero-byte.

---

## 📸 Demonstração

| Antes (Manual)                      | Depois (Pipeline)                        |
|------------------------------------|------------------------------------------|
| Operador abria 1 PDF por vez       | Script detecta e processa todos os PDFs  |
| Exportava TIFF manualmente         | TIFFs gerados com perfil de cor embutido |
| Criava pastas e movia arquivos     | Robocopy faz isso com verificação        |

---

## 🧠 Aprendizados Técnicos

- Paralelização com `Start-Job` no PowerShell
- Automação de imagem com `magick` CLI
- Manipulação robusta de arquivos e pastas
- Boas práticas de logs, tratamento de exceções e validação

---

## 🗺️ Próximos Passos

- Integração com macros VBA no CorelDRAW (projeto já existente) para continuação do pipeline
- Geração de relatórios de sucesso/erro (CSV ou dashboard)
- Versão em Python como estudo comparativo de performance

---

## 🐍 Complemento Python

Como parte da evolução do pipeline, implementamos uma versão complementar em Python com recursos adicionais como:

- Conversão de texto em curvas via `mutool`;
- Verificação de proporção do PDF (máx. 10:1);
- Cálculo de resolução automática com base na área em cm²;
- Geração de logs com fontes ausentes ou PDFs corrompidos.

📂 Repositório: [pdf-to-tiff-python](https://github.com/allisonfelix/PDF-To-TIFF-Python)

---

## 🤝 Créditos

Desenvolvido por [Allison dos Santos Felix](https://linkedin.com/in/allison-dos-santos-felix-743814a2), Analista de Sistemas Jr. com especialização em automações gráficas, pipelines híbridos e integração entre áreas técnicas e criativas.

---

## 📄 Licença

Uso interno. Para fins de demonstração técnica e aprendizado.

---


# 🖨️ PDF-to-TIFF Pipeline Automator – PowerShell + ImageMagick

This project automates the conversion of client-submitted PDF files into high-quality TIFF images for use in industrial graphic production workflows. It leverages **PowerShell** for orchestration and **ImageMagick** for preflight and page rasterization, while applying ICC color profiles and moving the files to the production environment.

🔧 Designed for a **high-volume B2B printing company**, this pipeline replaces time-consuming manual tasks that previously required opening individual pages in Photoshop.

## 🧩 Problem Context

At **Graficonauta**, we previously operated with an inefficient workflow where prepress operators had to:

- Manually open **PDFs page by page in Photoshop**  
- Export each page as a TIFF with DPI and CMYK settings manually adjusted  
- Create folders and move files to the production path manually  

🚫 This process took **5 to 10 minutes per file** and often led to bottlenecks, rework, and inconsistencies.

## ✅ The Solution

This pipeline now:

1. **Scans automatically** a pre-processing folder (fed by the ERP system from the website);  
2. **Processes all PDFs in parallel**, including multi-page files;  
3. **Batch converts TIFFs** with embedded ICC color profiles, LZW compression, and professional resolution (300 DPI);  
4. **Validates the output**, checking page count and generated TIFF files;  
5. **Moves folders** to the production department in a structured and safe manner.

## 📂 Project Structure

```
PDF-to-TIFF-Pipeline/
├── scripts/
│   └── pipeline.ps1           # Main PowerShell script
├── PerfisICC/
│   └── USWebCoatedSWOP.icc    # CMYK color profile
├── Tratamento/                # Input folder for raw PDFs
├── Pedidos/                   # Output folder with final files
├── README.md
```

## ⚙️ Technologies Used

- **PowerShell 5+**  
- **ImageMagick (convert / magick)**  
- **robocopy** (Windows CLI)  
- **ICC profiles for color management**  
- **Corporate Windows 10/11 environment**

## 🧾 Why Not Acrobat Pro or Photoshop?

While **Adobe Acrobat Pro** supports exporting PDFs to image formats (including TIFF), this approach:

- ⚠️ **Requires manual interaction** and per-export configuration;  
- 🖱️ Depends on human action, slowing down each task;  
- 💸 Requires a **paid license** of Acrobat Pro, which is not available on all workstations.

Likewise, scripting with **Photoshop (ExtendScript/JSX)** requires files to be manually opened and loses path references when dealing with PDF inputs — making automated batch processing fragile.

🎯 By contrast, this PowerShell + ImageMagick solution is **autonomous, parallel, and scalable**, ideal for high-throughput teams working with diverse machine environments.

## 📈 Real Impact

- ⏱️ Up to **90% reduction in processing time** for multi-page PDFs.  
- ⚙️ Robust and scalable pipeline for thousands of files per week.  
- 🔐 Fail-safe checks for zero-byte or corrupted files.

## 📸 Demonstration

| Before (Manual)                  | After (Pipeline)                         |
|----------------------------------|------------------------------------------|
| Operator opened 1 PDF at a time  | Script detects and processes all PDFs    |
| Exported TIFF manually           | TIFFs generated with embedded color profile |
| Created folders & moved files    | Robocopy automates file movement         |

## 🧠 Technical Highlights

- Parallel processing using `Start-Job` in PowerShell  
- CLI-based image automation via `magick`  
- Strong file/folder manipulation and exception handling  
- Clean logging and batch processing techniques

## 🗺️ Next Steps

- Integrate with existing CorelDRAW VBA macros to complete the production pipeline  
- Add logging and reporting (CSV or dashboard format)  
- Explore a Python-based version as a performance study

---

## 🐍 Python Complement

As part of the pipeline evolution, we've developed a complementary version in Python, featuring advanced capabilities such as:

- Text-to-outline conversion using `mutool`;
- Aspect ratio check (skips PDFs with proportions above 10:1);
- Dynamic resolution calculation based on page area in cm²;
- Logging of missing fonts and corrupted/incomplete PDFs.

📂 Repository: [pdf-to-tiff-python](https://github.com/allisonfelix/PDF-To-TIFF-Python)

---

## 🤝 Credits

Developed by [Allison dos Santos Felix](https://linkedin.com/in/allison-dos-santos-felix-743814a2), Junior Systems Analyst specialized in hybrid automation workflows for graphic production, prepress, and creative operations.

## 📄 License

Internal use only. For demonstration and technical education purposes.
