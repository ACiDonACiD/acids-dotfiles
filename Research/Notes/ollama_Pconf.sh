#!/bin/bash
#
# DATE: Fri 06 Jun 2025 04:33:48 SAST
#
# Current Version : ollama version is 0.9.0
# Ollama Automated Setup Script (TinyLLaMA)
#

# ─────────────────────────────────────────────────────────────
# 1. INSTALLATION
# ─────────────────────────────────────────────────────────────
# Ollama has a shell script to automate the installation process:
#
# Option 1:
#   curl https://ollama.com/install.sh | sh
#
# This will install the Ollama CLI and setup environment requirements.

# ─────────────────────────────────────────────────────────────
# 2. MODEL DOWNLOAD
# ─────────────────────────────────────────────────────────────
# To download TinyLLaMA, use the command below:
ollama pull tinyllama

# This downloads the TinyLLaMA GGUF model and makes it available locally.

# ─────────────────────────────────────────────────────────────
# 3. STARTING A CHAT SESSION
# ─────────────────────────────────────────────────────────────
# You can start chatting with your local model like this:

# Example (commented to avoid accidental execution):
#   ollama run tinyllama
#   > How do I write a bash script that logs to a JSON file?

# ─────────────────────────────────────────────────────────────
# 4. USING OLLAMA NON-INTERACTIVELY
# ─────────────────────────────────────────────────────────────
# You can pipe input into Ollama directly from other shell commands:

# Example (commented):
#   echo "Summarize this: The script processes log entries and outputs them to .jsonl files." | ollama run tinyllama

# ─────────────────────────────────────────────────────────────
# 5. SCRIPT INTEGRATION — summarize.sh
# ─────────────────────────────────────────────────────────────
# You can create a helper script to summarize file contents with Ollama:

# summarize.sh
# ----------------------------------
# #!/bin/bash
# ollama run tinyllama <<EOF
# Summarize this content:
# $(cat "$1")
# EOF

# Make it executable:
#   chmod +x summarize.sh
#   ./summarize.sh ./README.md

# ─────────────────────────────────────────────────────────────
# 6. INSTALLING OTHER MODELS
# ─────────────────────────────────────────────────────────────
# Looking to upgrade or specialize? Try these:

# Code generation and technical tasks:
#   ollama pull codellama
#   ollama run codellama

# Balanced general-purpose model:
#   ollama pull mistral
#   ollama run mistral

# ─────────────────────────────────────────────────────────────
# ✨ TIP: Each model has its strengths. Try a few and see what fits your workflow best.
# ─────────────────────────────────────────────────────────────

# 💬 Now you're ready to use Ollama as a CLI assistant in your projects.
# 📦 Happy hacking — and have fun with your local LLMs!

# NOTE : This is  personal .sh file and is not apart of ollama
