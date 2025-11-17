#!/bin/bash

EXIT_CODE=0
REASON=""

APP_FILE="app.py"
PLACEHOLDER="____TO BE FILLED____"

if [ ! -f "$APP_FILE" ]; then
    EXIT_CODE=1
    REASON="FAIL: 必需的文件 '$APP_FILE' 不存在。"
fi

if [ "$EXIT_CODE" -eq 0 ]; then
    if grep -q "$PLACEHOLDER" "$APP_FILE"; then
        EXIT_CODE=1
        REASON="FAIL: 文件 '$APP_FILE' 仍包含占位符 '$PLACEHOLDER'."
    fi
fi

if [ "$EXIT_CODE" -eq 0 ]; then
    ENV_FILE=".env"
    if [ -f "$ENV_FILE" ]; then
        EXIT_CODE=1
        REASON="FAIL: 检测到敏感的配置文件 '$ENV_FILE' 存在于当前目录。"
    fi
fi

if [ "$EXIT_CODE" -eq 0 ]; then
    echo "SUCCESS: 所有检查通过。可以运行。"
else
    echo "$REASON"
fi

exit $EXIT_CODE