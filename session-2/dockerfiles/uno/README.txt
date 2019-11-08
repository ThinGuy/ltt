#Build Docker Container
docker build -t uno .

# Run Docker Container
docker run -it --rm --name uno uno:latest
