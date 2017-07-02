# nuimo-raspbian-docker

```
docker build -t pfink2/rpi-nuimo-openhab:0.1 -t pfink2/rpi-nuimo-openhab:latest .
```

## Troubleshooting

Start container interactively with bash entrypoint to skip auto-starting of the nuimop-openhab app:
```
docker run -it --rm --entrypoint=/bin/bash --privileged --net=host --name=nuimo-openhab-debug -v /etc/nuimo-openhab:/etc/nuimo-openhab pfink2/rpi-nuimo-openhab
```
