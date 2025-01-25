sudo add-apt-repository ppa:savoury1/ffmpeg4
sudo add-apt-repository ppa:savoury1/chromium
sudo apt-get update
sudo apt-get install chromium-browser 
export DISPLAY=:0
chromium-browser --in-process-gpu --no-sandbox --test-type --disable-dev-shm-usage --start-maximized --display=:0
