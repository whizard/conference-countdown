#!/bin/bash

export PORT=3000
pgrep countdown | xargs kill -9 2>/dev/null

./dist/countdown&

firefox "--kiosk" http://localhost:3000/?json=/wdc2023.json&track=A&show_seconds=true

