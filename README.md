# Neural Trace

Neural Trace is an interactive Bash-based CLI tool that performs local system reconnaissance and translates raw OS signals (processes, network activity, open ports, uptime, etc.) into understandable security insights with guided recommendations.

## Setup & Run

```bash
git clone https://github.com/brittneyleighb/neural-trace.git
cd neural-trace
sudo apt update
sudo apt install jq curl ufw
chmod +x neural-trace.sh
./neural-trace.sh

## Commands

- `scan` — run system reconnaissance  
- `show` — display latest report  
- `ports` — show open ports  
- `secure` — run security checks and offer fixes  
- `analyze` — AI-based analysis (optional)  
- `ask` — ask AI questions about the system  
- `help` — show commands  
- `exit` — quit  

## AI Add-On (Optional)
Neural Trace can use AI for analysis. To enable it, set your OpenAI API key as an environment variable before running the tool:

```bash
export OPENAI_API_KEY="your_api_key_here"
./neural-trace.sh

This only lasts for your current terminal sesson. Do not hardcode your API key into the script and never commit your API key to Github.

## Notes

- Tested on Kali Linux (should work on Debian-based systems)  
- Does not apply system changes without user confirmation  
- Designed as a learning tool to bridge system data → interpretation → actionable insight  
