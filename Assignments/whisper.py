from openai import OpenAI

client = OpenAI()

with open("Interview.m4a","rb") as audio:
    transcript = client.audio.transcriptions.create(
        model="whisper-1",
        file=audio
    )

print(transcript.text)