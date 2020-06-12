locals {
  is_infra = terraform.workspace == "infra" ? true : false
}

resource "kubernetes_service_account" "jenkins" {
  count =  local.is_infra ? 1:0
  metadata {
    name = "terraform-jenkins"
  }
}

resource "kubernetes_role" "jenkins" {
  count =  local.is_infra ? 1:0
  metadata {
    name = "terraform-jenkins"
  }
  rule {
    api_groups     = [""]
    resources      = ["pods"]
    verbs          = ["create","delete","get","list","patch","update","watch"]
  }
  rule {
    api_groups     = [""]
    resources      = ["pods/exec"]
    verbs          = ["create","delete","get","list","patch","update","watch"]
  }
  rule {
    api_groups     = [""]
    resources      = ["pods/log"]
    verbs          = ["get","list","watch"]
  }
  rule {
    api_groups     = [""]
    resources      = ["events"]
    verbs          = ["watch"]
  }
  rule {
    api_groups     = [""]
    resources      = ["secrets"]
    verbs          = ["get"]
  }
}

resource "kubernetes_role_binding" "jenkins" {
  count =  local.is_infra ? 1:0
  metadata {
    name      = "terraform-jenkins"
    namespace = "default"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "jenkins"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "jenkins"
    namespace = "kube-system"
  }
}

