FROM apache/spark@sha256:d0f5d63bfbbffdbec08debb4911554ba671a2fa7398374db8db314d80328f576
USER root
RUN mkdir -p /opt/spark/iceberg-jars /opt/spark/conf /home/spark/.beeline && chown -R 185:0 /home/spark
COPY jars/ /opt/spark/iceberg-jars/
RUN echo 'cdf7357865d8d91764e0f147a2d76bc3e1e2b8792ddc0d3be329b3d34aaf218c  /opt/spark/iceberg-jars/iceberg-spark-runtime-3.5_2.12-1.7.1.jar' | sha256sum -c - && \
    echo '5d7c0baf877ee4296c4f98425165484404af4227fb487f1847a3cb1a577dfc3b  /opt/spark/iceberg-jars/iceberg-aws-bundle-1.7.1.jar' | sha256sum -c -
COPY start-thrift.sh /opt/spark/start-thrift.sh
RUN sed -i 's/\r$//' /opt/spark/start-thrift.sh && chmod 755 /opt/spark/start-thrift.sh && chown -R 185:0 /opt/spark/conf
USER 185
CMD ["/bin/bash", "/opt/spark/start-thrift.sh"]
