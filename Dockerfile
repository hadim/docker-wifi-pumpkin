FROM ubuntu:18.10

# Install system-wide dependencies.
RUN apt update && apt install -y \
    curl wget nano bzip2 build-essential \
    libnetfilter-queue-dev \
    hostapd rfkill git libpcap-dev \
    libsm6 libxrender1 libfontconfig1 \
    wireless-tools iw net-tools rfkill \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log

# Install Python with Conda.
RUN curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh \
    && conda config --add channels conda-forge \
    && conda install -y python=2.7 \
    && conda update conda \
    && conda clean --all --yes

RUN  git clone https://github.com/P0cL4bs/WiFi-Pumpkin.git /pumpkin

# Install netfilterqueue manually.
RUN git clone https://github.com/kti/python-netfilterqueue.git
RUN cd python-netfilterqueue && \
    git checkout ec2ae290667b2d3f09d5ec1278d899db2f08c52f
RUN . /usr/local/etc/profile.d/conda.sh && \
    conda activate base && \
    cd python-netfilterqueue && \
    python setup.py install

# Necessary to make Qt GUI to work.
ENV QT_X11_NO_MITSHM=1

# Install Pumpkin dependencies.
COPY environment.yml /environment.yml
COPY requirements.txt /requirements.txt

RUN . /usr/local/etc/profile.d/conda.sh && \
    conda activate base && \
    conda env update -f /environment.yml && \
    pip install --no-deps -r /requirements.txt

WORKDIR /pumpkin
CMD python wifi-pumpkin.py
