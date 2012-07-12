#!/bin/bash
# Rutare Retea eRegie
#
# Daca te muti in alt camin va trebui sa vii si sa redownloadezi acest fisier
# FISIERUL TREBUIE DOWNLOADAT NUMAI DE LA ADRESA http://www.eregie.pub.ro/downloads/retea.bat
#
#
route del -net 10.0.0.0 netmask 255.0.0.0
route add -net 10.0.0.0 netmask 255.0.0.0 gw 10.16.0.1

