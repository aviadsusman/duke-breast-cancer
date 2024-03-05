.PHONY: venv data

current_dir := $(CURDIR)
NBIADataRetriever_path = /opt/NBIADataRetriever

#### Build virtual environment and install packages
venv: venv/bin/activate ## Create virtual environment and download required packages from requirements.txt
venv/bin/activate: requirements.txt
	python -m venv venv
	. venv/bin/activate; pip install --upgrade pip; pip install -r requirements.txt; pip install "git+https://github.com/03bennej/ei-python.git"; pip install -e .;

duke:
	wget -nc -P data/raw/duke https://wiki.cancerimagingarchive.net/download/attachments/70226903/Clinical_and_Other_Features.xlsx
	wget -nc -P data/raw/duke https://wiki.cancerimagingarchive.net/download/attachments/70226903/Breast-Cancer-MRI-filepath_filename-mapping.xlsx
	wget -nc -P data/raw/duke https://wiki.cancerimagingarchive.net/download/attachments/70226903/Imaging_Features.xlsx 
	wget -nc -P data/raw/duke https://wiki.cancerimagingarchive.net/download/attachments/70226903/Annotation_Boxes.xlsx
	wget -nc -P data/raw/duke https://wiki.cancerimagingarchive.net/download/attachments/70226903/Duke-Breast-Cancer-MRI_v2_20220609.tcia
	sudo $(addprefix $(NBIADataRetriever_path)/, NBIADataRetriever) --cli $(addprefix $(current_dir)/, Duke-Breast-Cancer-MRI_v2_20220609.tcia) -d /$(addprefix $(current_dir)/, data/raw/duke) -l $(addprefix $(current_dir)/, NBIADataRetriever_credentials.txt)