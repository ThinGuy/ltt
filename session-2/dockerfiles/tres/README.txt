docker build -f Dockerfile.beep -t tres:beep-beep .

docker run --rm -it --name beep-beep --rm --env GREETING=Hi --env NAME=Craig tres:beep-beep


docker build -f Dockerfile.racers -t tres:emojo-racers .

docker run --rm -it --name emoji-racers --env NAMES=Craig,Denae,Chloe,Delaney,Maggie,Campbell,Bellamy tres:emoji-racers
