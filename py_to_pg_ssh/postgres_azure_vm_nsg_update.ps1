az login
# Allow
# Deny
az network nsg rule update --name Port_5432 --nsg-name ubuntubox-nsg --resource-group ubuntuboxresgrp --access Deny