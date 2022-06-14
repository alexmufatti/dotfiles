#!/bin/bash
rsync -crv -zz --no-perms --no-owner --no-group --no-times --delete --exclude 'var/cache' --exclude 'media/catalog/product/cache' --exclude 'var' --chmod=Du=rwx,Dgo=,Fu=rw,Fog=  root@mon01.montalbettisrl.com:/var/www/montalbettisrl.com/ /home/mua/Projects/ecommerce/magento
