PHONY: publish

publish:
	rsync -avzc --exclude '.*' ./ nickcharlton.net:/var/www/boxes
