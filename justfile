root := justfile_directory()

[private]
default:
	@just --list --unsorted

# Install package.
install target="preview":
  bash scripts/package.sh install "{{target}}" "{{root}}"
  
# Remove package.
remove target="preview":
  bash scripts/package.sh remove "{{target}}" "{{root}}"
  
# Install package in both "local" and "preview" namespaces.
install-all:
  bash scripts/package.sh install "local" "{{root}}"
  bash scripts/package.sh install "preview" "{{root}}"

# Generate documentation PDFs in dev/
pdf:
  mkdir "dev" 2>/dev/null || true
  bash scripts/package.sh check "" "{{root}}"
  typst c "manual.typ" "dev/manual.pdf"
  typst c "template/main.typ" "dev/example.pdf"
  typst c "template/parts/doc.typ" "dev/doc.pdf"
  typst c "template/parts/glossary.typ" "dev/glossary.pdf"
  typst c "template/parts/syntax.typ" "dev/syntax.pdf"

# Generate documentation as PNGs in dev/png/
png:
  rm -r "dev/png" 2>/dev/null || true
  mkdir -p "dev/png" 2>/dev/null || true
  bash scripts/package.sh check "" "{{root}}"
  typst c "manual.typ" "dev/png/manual-{0p}.png"
  typst c "template/main.typ" "dev/png/example-{0p}.png"
  typst c "template/parts/doc.typ" "dev/png/doc-{0p}.png"
  typst c "template/parts/glossary.typ" "dev/png/glossary-{0p}.png"
  typst c "template/parts/syntax.typ" "dev/png/syntax-{0p}.png"

# Toggle symlink this project to "local" namespace under 0.0.0 version.
dev-link:
  bash scripts/dev-link.sh "{{root}}"

# Release a new package version.
version v:
  bash scripts/version.sh "{{v}}" "{{root}}"

# Init Typst template project in dev/
init target="preview":
  bash scripts/init.sh "{{target}}" "{{root}}"
  
[private]
all:
  @just install-all
  @just init
  @just install "pkg"
  @just pdf