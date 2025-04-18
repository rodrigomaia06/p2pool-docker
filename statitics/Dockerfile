# Use a slim Python image as the base image
FROM python:slim

# Install dependencies (Git, etc.)
RUN apt-get update -q && apt-get install -y git

# Clone the statistics repository directly from GitHub
RUN git clone https://github.com/SChernykh/p2pool.git /app

# Set the working directory to the statistics app folder
WORKDIR /app/docker-compose/statistics/app

# Install required Python packages
RUN pip install -r requirements.txt

# Expose the necessary ports (if any for statistics, e.g., API server port)
EXPOSE 5000

# Set the stop signal
STOPSIGNAL SIGINT

# Command to run the statistics application
CMD ["python", "p2pool_statistics.py"]
