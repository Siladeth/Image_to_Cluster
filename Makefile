all: build deploy-ansible expose

build:
	@echo " Building image with Packer..."
	cd packer && packer init . && packer build .

deploy-ansible:
	@echo " Deploying to K3d with Ansible..."
	cd ansible && ansible-playbook deploy.yml

expose:
	@echo " Exposing service..."
	kubectl port-forward svc/nginx-service 8081:80 >/tmp/nginx.log 2>&1 &
	@echo "Application disponible sur le port 8081 (onglet PORTS)"

clean:
	k3d cluster delete lab