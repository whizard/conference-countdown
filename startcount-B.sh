#!/bin/bash

export PORT=3000
pgrep countdown | xargs kill -9 2>/dev/null

./dist/countdown&

firefox "--kiosk" "http://localhost:3000/?json=/test.json&track=B&show_seconds=true"

sleep 4

unclutter -idle 3 &
