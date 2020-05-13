function test() {
	navigator.mediaDevices.getUserMedia({ screen: true, audio: true })
		.then(async (stream) => {
			let recorder = RecordRTC(stream, { type: 'video' });
			recorder.startRecording();
			const sleep = m => new Promise(r => setTimeout(r, m));
			await sleep(10);

			await recorder.stopRecording();
			let blob = await recorder.getBlob();
			console.log(blob);
			invokeSaveAsDialog(blob);
		});
}
