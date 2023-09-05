.PHONY: venv data

#### Build virtual environment and install packages
venv: venv/bin/activate ## Create virtual environment and download required packages from requirements.txt
venv/bin/activate: requirements.txt
	python -m venv venv
	. venv/bin/activate; pip install --upgrade pip; pip install -r requirements.txt; pip install "git+https://github.com/03bennej/ei-python.git"; pip install -e .;

data:
	wget -P data/raw https://wiki.cancerimagingarchive.net/download/attachments/70226903/Clinical_and_Other_Features.xlsx
	wget -P data/raw https://wiki.cancerimagingarchive.net/download/attachments/70226903/Breast-Cancer-MRI-filepath_filename-mapping.xlsx
	wget -P data/raw https://wiki.cancerimagingarchive.net/download/attachments/70226903/Imaging_Features.xlsx 
	wget -P data/raw https://wiki.cancerimagingarchive.net/download/attachments/70226903/Annotation_Boxes.xlsx

images:
	wget -nc -P data/raw https://wiki.cancerimagingarchive.net/download/attachments/70226903/Duke-Breast-Cancer-MRI_v2_20220609.tcia
	sudo /opt/NBIADataRetriever/NBIADataRetriever --cli /home/opc/storage/duke-breast-cancer/data/raw/Duke-Breast-Cancer-MRI_v2_20220609.tcia -d /home/opc/storage/duke-breast-cancer/data/raw -l /home/opc/storage/duke-breast-cancer/NBIADataRetriever_credentials.txt

