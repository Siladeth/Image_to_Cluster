# 🚀 Atelier DevOps : De l'Image au Cluster (Packer & Ansible)

Ce projet illustre l'industrialisation du cycle de vie d'une application web. Nous automatisons la création d'une image **Nginx** personnalisée avec **Packer**, puis son déploiement sur un cluster **K3d** via **Ansible**, le tout dans l'environnement **GitHub Codespaces**.

---

## 🏗️ Architecture de la Solution

L'infrastructure repose sur trois piliers majeurs :
1.  **Immuabilité (Packer)** : Création d'une image Docker figée contenant notre `index.html`.
2.  **Orchestration (K3d)** : Un cluster Kubernetes léger (1 Master, 2 Workers) pour l'exécution.
3.  **Automation (Ansible)** : Pilotage du déploiement (import de l'image et création des ressources K8s).

[Image of Kubernetes cluster architecture with master and worker nodes]

---

## 🛠️ Installation des Outils

Si vous repartez d'un environnement vierge dans Codespaces, exécutez ces commandes :

 1. Installation de Packer (Binaire)
```
curl -O [https://releases.hashicorp.com/packer/1.11.2/packer_1.11.2_linux_amd64.zip](https://releases.hashicorp.com/packer/1.11.2/packer_1.11.2_linux_amd64.zip)
sudo apt-get install unzip -y
unzip packer_1.11.2_linux_amd64.zip
sudo mv packer /usr/local/bin/
```
 2. Installation d'Ansible & Dépendances K8s
```
pip install ansible kubernetes
ansible-galaxy collection install kubernetes.core
```
### Déploiement du lab

Étape 1 : Initialisation du Cluster K3d
```
k3d cluster create lab --servers 1 --agents 2
```
Étape 2 : Build de l'Image avec Packer
```
cd packer
packer init .
packer build .
cd ..
```
Cette étape crée une image Docker locale nommée my-custom-nginx:v1.

Étape 3 : Déploiement via Ansible
Le playbook gère l'import de l'image locale dans le cluster et le déploiement du manifeste :


```
cd ansible
ansible-playbook deploy.yml
```
#### 🔍 Vérification et Accès
Une fois le déploiement terminé, vérifiez le statut des Pods :

```
kubectl get pods
Accès à l'interface Web
```
Pour visualiser votre page index.html personnalisée dans Codespaces, créez un tunnel vers le service :
```
kubectl port-forward svc/nginx-service 8080:80
```
Rendez-vous dans l'onglet PORTS de l'interface Codespaces, et ouvrez l'URL associée au port 8080.
