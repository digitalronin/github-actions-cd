apiVersion: apps/v1
kind: Deployment
metadata:
  name: helloworld-nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: webserver
  template:
    metadata:
      labels:
        app: webserver
    spec:
      containers:
      - name: nginx
        image: 754256621582.dkr.ecr.eu-west-2.amazonaws.com/${ECR}:${IMAGE_TAG}
        ports:
        - containerPort: 8080
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
  labels:
    app: nginx-service
spec:
  ports:
  - port: 8080
    name: http
    targetPort: 8080
  selector:
    app: webserver
---
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: helloworld-nginx-ingress
  annotations:
    kubernetes.io/ingress.class: nginx
spec:
  tls:
  - hosts:
    - dstest.apps.live-1.cloud-platform.service.justice.gov.uk
  rules:
  - host: dstest.apps.live-1.cloud-platform.service.justice.gov.uk
    http:
      paths:
      - path: /
        backend:
          serviceName: nginx-service
          servicePort: 8080
