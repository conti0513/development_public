#!/bin/bash
# 色付け
GREEN='\033[0-32m'
YELLOW='\033[0-33m'
BLUE='\033[0-34m'
NC='\033[0m'

echo -e "${BLUE}=== [Step 1: Syntax Check] ===${NC}"
node --check app/legacy/legacy_system.js && echo -e "${GREEN}Syntax OK${NC}" || { echo -e "${YELLOW}Syntax Error! Check your braces.${NC}"; exit 1; }

echo -e "${BLUE}=== [Step 2: Logic Order Check] ===${NC}"
START_LINE=$(grep -n "app.start" app/legacy/legacy_system.js | cut -d: -f1)
DEBUG_LINE=$(grep -n "/direct-debug" app/legacy/legacy_system.js | cut -d: -f1)

if [ -z "$DEBUG_LINE" ]; then
    echo -e "${YELLOW}Warning: /direct-debug endpoint not found.${NC}"
elif [ "$DEBUG_LINE" -gt "$START_LINE" ]; then
    echo -e "${YELLOW}Critical: /direct-debug is AFTER app.start (it will not work).${NC}"
    echo "app.start is at line $START_LINE, but /direct-debug is at line $DEBUG_LINE"
else
    echo -e "${GREEN}Order OK: /direct-debug is registered before app.start.${NC}"
fi

echo -e "${BLUE}=== [Step 3: Preview] ===${NC}"
cat -n app/legacy/legacy_system.js
