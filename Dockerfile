# % Last Change: Fri Sep 15 08:45:30 PM 2023 CDT
# Base Image
FROM debian:10

# File Author / Maintainer
MAINTAINER Tiandao Li <litd99@gmail.com>

ENV PATH /opt/conda/bin:$PATH

# Installation
RUN apt-get update --fix-missing && \
    apt-get install -y \
    locales \
    curl \
    python3 \
    python3-pip \
    python3-pysam \
    r-base \
    r-cran-car && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    locale-gen en_US.UTF-8 && \
    echo 'install.packages("betareg",repos="http://cran.us.r-project.org")' > /opt/packages.R && \
    /usr/bin/Rscript /opt/packages.R && \
    rm /opt/packages.R && \
    mkdir -p /usr/local/lib/R/site-library /usr/lib/R/site-library && \
    curl -fsSL https://cran.r-project.org/src/contrib/Archive/gcmr/gcmr_1.0.2.tar.gz -o /opt/gcmr_1.0.2.tar.gz && \
    /usr/bin/R CMD INSTALL /opt/gcmr_1.0.2.tar.gz && \
    rm /opt/gcmr_1.0.2.tar.gz && \
    pip3 install lifelines liqa && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/log/dpkg.log /var/tmp/*

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# set timezone, debian and ubuntu
RUN ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime && \
	echo "America/Chicago" > /etc/timezone

CMD [ "/bin/bash" ]

