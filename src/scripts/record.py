from selenium import webdriver
import time
options =  webdriver.FirefoxOptions()
#options.set_preference("dom.webnotifications.enabled", True)
options.set_preference("media.devices.insecure.enabled", True)
options.set_preference("media.getusermedia.insecure.enabled", True)
options.set_preference("permissions.default.microphone", True)
browser = webdriver.Firefox(options=options)
load_script = """
let s = document.createElement('script');
let s2 = document.createElement('script');
s2.src = 'https://www.webrtc-experiment.com/getScreenId.js';
s.src = 'https://www.WebRTC-Experiment.com/RecordRTC.js';
window.document.head.appendChild(s2);
window.document.head.appendChild(s);
"""
play_script = """
getScreenId(function (error, souceId, screenConstraints) {
            if (error === 'not-installed') {
                document.write('<h1><a target="_blank" href="https://chrome.google.com/webstore/detail/screen-capturing/ajhifddimkapgcifgcodmmfdlknahffk">Please install this chrome extension then reload the page.</a></h1>');
            }
            if (error === 'permission-denied') {
                alert('Screen capturing permission is denied.');
            }
            if (error === 'installed-disabled') {
                alert('Please enable chrome screen capturing extension.');
            }
            if (error) {
                config.onMediaCapturingFailed(error);
                return;
            }
            screenConstraints.audio = true;
            navigator.mediaDevices.getUserMedia(screenConstraints).then(async function (stream) {
                let recorder = RecordRTC(stream, {
                    type: 'video'
                });
                recorder.startRecording();
                const sleep = m => new Promise(r => setTimeout(r, m));
                await sleep(3000);
                recorder.stopRecording(function () {
                    let blob = recorder.getBlob();
                    invokeSaveAsDialog(blob);
                });
            });
        })
"""
browser.get("https://www.youtube.com")
browser.execute_script(load_script)
time.sleep(2)
browser.execute_script(play_script)
