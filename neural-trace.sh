#!/bin/bash

GREEN="\e[32m"
CYAN="\e[36m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

REPORT_FILE="neural_trace_report.txt"

typewriter() {
  text="$1"
  delay="${2:-0.03}"

  for ((i=0; i<${#text}; i++)); do
    echo -n "${text:$i:1}"
    sleep "$delay"
  done

  echo
}

section() {
  echo
  echo -e "${CYAN}[+] $1${RESET}"
  echo "--------------------------------------"
}

banner() {
  clear
  echo -e "${GREEN}"
  echo "======================================"
  echo "          NEURAL-TRACE v1"
  echo "======================================"
  echo -e "${RESET}"

  typewriter "Initializing neural link..." 0.04
  typewriter "Local system consciousness detected." 0.04
  echo
}

generate_report() {
  {
    echo "NEURAL-TRACE LOCAL SYSTEM REPORT"
    echo "Generated: $(date)"
    echo

    echo "[Identity]"
    echo "User: $(whoami)"
    echo "Host: $(hostname)"
    echo

    echo "[Kernel / OS]"
    uname -a
    echo

    echo "[Logged-in Users]"
    who
    echo

    echo "[Network Interfaces]"
    ip -brief addr
    echo

    echo "[Listening Ports]"
    ss -tuln
    echo

    echo "[Top Memory Processes]"
    ps aux --sort=-%mem | head -n 10
    echo

    echo "[Disk Usage]"
    df -h
    echo

    echo "[Uptime]"
    uptime
  } > "$REPORT_FILE"

  echo -e "${GREEN}[+] Report saved to $REPORT_FILE${RESET}"
}

show_report() {
  if [ ! -f "$REPORT_FILE" ]; then
    echo -e "${RED}[!] No report found. Run 'scan' first.${RESET}"
    return
  fi

  section "Identity Layer"
  grep -A 3 "\[Identity\]" "$REPORT_FILE"

  section "Machine Layer"
  grep -A 3 "\[Kernel / OS\]" "$REPORT_FILE"

  section "Network Layer"
  grep -A 20 "\[Network Interfaces\]" "$REPORT_FILE"

  section "Listening Doors"
  grep -A 20 "\[Listening Ports\]" "$REPORT_FILE"

  section "Memory Vampires"
  grep -A 12 "\[Top Memory Processes\]" "$REPORT_FILE"

  section "Disk Footprint"
  grep -A 10 "\[Disk Usage\]" "$REPORT_FILE"

  section "Uptime"
  grep -A 3 "\[Uptime\]" "$REPORT_FILE"
}

ai_analysis() {
  if [ ! -f "$REPORT_FILE" ]; then
    echo -e "${RED}[!] No report found. Run 'scan' first.${RESET}"
    return
  fi

  if [ -z "$OPENAI_API_KEY" ]; then
    echo -e "${RED}[!] OPENAI_API_KEY is not set.${RESET}"
    echo "Run:"
    echo "export OPENAI_API_KEY=\"your_api_key_here\""
    return
  fi

  if ! command -v jq >/dev/null 2>&1; then
    echo -e "${RED}[!] jq is not installed.${RESET}"
    echo "Install it with:"
    echo "sudo apt install jq"
    return
  fi

  section "AI Analysis"
  typewriter "Routing report through neural interpreter..." 0.04

  REPORT_CONTENT=$(cat "$REPORT_FILE")

  JSON_PAYLOAD=$(jq -n \
    --arg report "$REPORT_CONTENT" \
    '{
      model: "gpt-5.5",
      input: "You are a beginner-friendly cybersecurity assistant. Analyze this local system recon report. Explain what looks normal, what looks interesting, and suggest safe next steps. Do not suggest attacking third-party systems.\n\nReport:\n\($report)"
    }')

  curl -s https://api.openai.com/v1/responses \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -H "Content-Type: application/json" \
    -d "$JSON_PAYLOAD" | jq -r '.output_text'
}

ask_ai() {
  if [ ! -f "$REPORT_FILE" ]; then
    echo -e "${RED}[!] No report found. Run 'scan' first.${RESET}"
    return
  fi

  if [ -z "$OPENAI_API_KEY" ]; then
    echo -e "${RED}[!] OPENAI_API_KEY is not set.${RESET}"
    return
  fi

  if ! command -v jq >/dev/null 2>&1; then
    echo -e "${RED}[!] jq is not installed.${RESET}"
    return
  fi

  echo -ne "${YELLOW}Ask the AI about this system > ${RESET}"
  read -r QUESTION

  REPORT_CONTENT=$(cat "$REPORT_FILE")

  JSON_PAYLOAD=$(jq -n \
    --arg report "$REPORT_CONTENT" \
    --arg question "$QUESTION" \
    '{
      model: "gpt-4.1-mini",
      input: "You are helping a beginner learn cybersecurity safely. Use this local recon report to answer their question. Keep it clear and practical. Do not provide instructions for attacking third-party systems.\n\nReport:\n\($report)\n\nQuestion:\n\($question)"
    }')

curl -s https://api.openai.com/v1/responses \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$JSON_PAYLOAD" | jq -r '
    if .error then
      "API error: " + .error.message
    else
      [.output[]? 
        | select(.type=="message") 
        | .content[]? 
        | select(.type=="output_text") 
        | .text
      ] | join("\n")
    end
'
}

show_ports() {
  section "Listening Doors"
  ss -tuln
}

show_help() {
  echo
  echo "Commands:"
  echo "  scan      - generate a fresh system recon report"
  echo "  show      - display the latest report"
  echo "  ports     - show listening ports only"
  echo "  analyze   - ask AI to analyze the latest report"
  echo "  ask       - ask AI a custom question about the report"
  echo "  clear     - clear the terminal"
  echo "  help      - show this help menu"
  echo "  secure    - run local  security checks and offer safe fixes"
  echo "  exit      - quit Neural-Trace"
}

security_check() {
  section "Security Check"

  if ! command -v ufw >/dev/null 2>&1; then
    echo -e "${YELLOW}[!] UFW firewall is not installed.${RESET}"
    echo -ne "Install UFW now? (y/n): "
    read -r answer

    if [ "$answer" = "y" ]; then
      sudo apt update
      sudo apt install ufw
    fi
  fi

  if command -v ufw >/dev/null 2>&1; then
    FIREWALL_STATUS=$(sudo ufw status | head -n 1)

    if echo "$FIREWALL_STATUS" | grep -q "inactive"; then
      echo -e "${RED}[!] Firewall is inactive.${RESET}"
      echo -ne "Enable firewall now? (y/n): "
      read -r answer

      if [ "$answer" = "y" ]; then
        sudo ufw enable
        echo -e "${GREEN}[+] Firewall enabled.${RESET}"
      else
        echo -e "${YELLOW}[!] Firewall left inactive.${RESET}"
      fi
    else
      echo -e "${GREEN}[+] Firewall appears active.${RESET}"
    fi
  fi

  PORT_COUNT=$(ss -tuln | tail -n +2 | wc -l)

  echo
  echo "Listening port count: $PORT_COUNT"

  if [ "$PORT_COUNT" -gt 10 ]; then
    echo -e "${YELLOW}[!] Many listening ports detected.${RESET}"
    echo "Run 'ports' to inspect them."
  else
    echo -e "${GREEN}[+] Listening port count looks reasonable.${RESET}"
  fi
}

interactive_mode() {
  typewriter "Neural interface ready. Type 'help' to begin." 0.04

  while true; do
    echo -ne "\n${GREEN}neural-trace > ${RESET}"
    read -r CMD

    case "$CMD" in
      scan)
        typewriter "Initiating local system scan..." 0.04
        generate_report
        show_report
        ;;

      show)
        show_report
        ;;

      ports)
        show_ports
        ;;

      analyze)
        ai_analysis
        ;;

      ask)
        ask_ai
        ;;

      clear)
        clear
        banner
        ;;

      help)
        show_help
        ;;
     
      secure)
        security_check
        ;;

      exit)
        typewriter "Disconnecting neural link..." 0.04
        break
        ;;

      "")
        ;;

      *)
        echo -e "${RED}[!] Unknown command.${RESET}"
        echo "Type 'help' to see available commands."
        ;;
    esac
  done
}

banner
interactive_mode

echo
echo -e "${GREEN}"
typewriter "Trace complete. The machine whispered back." 0.04
echo -e "${RESET}"
