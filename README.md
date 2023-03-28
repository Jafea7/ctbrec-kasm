# Docker container for CTBRec standalone/client using KasmWeb.

---

CTBRec is a streaming media recorder.

---


`docker-compose.yml`
~~~
version: '3.3'
services:
  ctbrec-kasm:
    image: 'jafea7ctbrec-kasm:amd64_5.0.1' # Change to your desired image
    ports:
      - '6901:6901' # Set host port as necessary. eg. '33901:6901'
    environment:
      - VNC_PW=mypassword  # Change as desired
      - TZ=America/Chicago # Set to required TZ
    shm_size: '1gb'
    volumes:
      - "./config:/home/kasm-user/ctbrec/config" # CTBRec config location
      - "./media:/home/kasm-user/media"          # Location of recorded media
    restart: "unless-stopped"
~~~

CTBRec will start when the container starts, (there's a delay of 10 seconds), access via your browser at `https://<ip>:<port>` with username `kasm_user`, password `whatever you set above`.

**NOTE:** CTBRec **will not** auto-start for the ARM64 container.

For example, using the settings in the `docker-compose.yml` above for a container on the local machine:

`https://127.0.0.1:6901`

User: `kasm_user`

Pass: `mypassword`


The image also contains a web browser, (Falkon), a media player, (mpv), image viewer (feh), text editor (featherpad), and curl (for send2xxxx.sh scripts).
