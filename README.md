# 🐍 Python Persistent Web Terminal

A lightweight, browser-accessible Python workspace that **never sleeps**. 

Built with **Python 3.9 Slim**, **Ttyd** (Web Terminal), and **Tmux** (Session Persistence), this image allows you to run long-term automation scripts or crawlers and reconnect to the same session from any device.

## ✨ Features

* **🌐 Web Access**: Full terminal access via browser (WebSocket).
* **🔄 Session Persistence**: Close the tab, but keep the process running. Powered by `tmux`.
* **⚡ Lightweight**: Built on `python:3.9-slim`, minimized size.
* **🛠 Pre-configured**: Ready for scraping & automation out of the box.
    * `requests` & `lxml`: For fast HTTP requests and parsing.
    * `PyExecJS` + `Node.js`: For handling JavaScript reverse-engineering.
    * `schedule`: For timing jobs.

## 🚀 Quick Start

Run the container directly from GitHub Container Registry:

```bash
docker run -d \
  --name my-workspace \
  -p 8080:7681 \
  ghcr.io/hohouman/my-python-persistent-workspace:latest
