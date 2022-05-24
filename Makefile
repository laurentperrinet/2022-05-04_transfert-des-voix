default: 2022-05-18

J=jupyter nbconvert  --ExecutePreprocessor.timeout=0 --allow-errors --execute
# J=jupyter nbconvert  --ExecutePreprocessor.kernel_name=python3 --ExecutePreprocessor.timeout=0 --allow-errors --execute
JN=$(J) --to notebook --inplace

2022-05-18:
	$(JN) 2022-05-23_transfert-des-voix.ipynb
	git commit -m 'results notebook' -a
	git push
	$(JN) 2022-05-04_transfert-des-voix.ipynb
	git commit -m 'results notebook' -a
	git push
