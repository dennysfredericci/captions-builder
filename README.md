# Create a Virtual Environment

```
python -m venv venv
source venv/bin/activate 
pip install -r requirements.txt
```

# Activate the Virtual Environment

```
source venv/bin/activate
```


# Freeze Installed Packages

```
pip freeze > requirements.txt
```

# Install all dependencies

```
pip install -r ./requirements.txt
```

# Extract Captions

## Create SRT

```
whisper --model large --highlight_words True --word_timestamps True --max_line_width 18 --max_line_count 2  --language pt ./test/shorts.mp4 --output_format srt
```



## Convert to ASS

```
ffmpeg -i  ./shorts.srt -c:s ass -metadata:s:s:0 language=pt ./shorts.ass
```

## Bur the ASS to the video

```
ffmpeg -i ./test/shorts.mp4 -vf "ass=./shorts.ass" -c:a copy ./test/shorts_output.mp4
```

ffmpeg -i ./test/shorts.mp4 -vf "ass=./shorts_new.ass" -c:a copy ./test/shorts_output_ass.mp4

## Bur the SRT to the video

```
ffmpeg -i ./test/shorts.mp4 -vf "subtitles=./test/shorts.srt" -c:a copy ./test/shorts_output_srt.mp4
```

## Bur the VTT to the video
```
ffmpeg -i ./test/shorts.mp4 -vf "subtitles=shorts.vtt" -c:a copy ./test/shorts_output_vtt.mp4
```

