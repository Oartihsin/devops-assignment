resource "kubernetes_namespace" "Rattle_NS" {
  metadata {
    name = "exercise"
  }
}
resource "kubernetes_deployment" "Rattle_Deployment" {
  metadata {
    name      = "hello-world-deployment"
    namespace = kubernetes_namespace.Rattle_NS.metadata.0.name
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "MyTestApp"
      }
    }
    template {
      metadata {
        labels = {
          app = "MyTestApp"
        }
      }
      spec {
        container {
          image = "registry-1.docker.io/oartihsin/hello-world-flask:v6"
          name  = "hello-world-container"
          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "Rattle_Service" {
  metadata {
    name      = "hello-world-service"
    namespace = kubernetes_namespace.Rattle_NS.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.Rattle_Deployment.spec.0.template.0.metadata.0.labels.app
    }
    type = "LoadBalancer"
    port {
      port        = 5000
      target_port = 5000
    }
  }
}