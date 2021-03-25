#!/bin/bash

grep '05:00:00 AM'  0310_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' > Dealers_working_during_losses
grep '08:00:00 AM'  0310_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' >> Dealers_working_during_losses
grep '02:00:00 PM'  0310_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' >> Dealers_working_during_losses
grep '08:00:00 PM'  0310_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' >> Dealers_working_during_losses
grep '11:00:00 PM'  0310_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' >> Dealers_working_during_losses
grep '05:00:00 AM'  0312_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' >> Dealers_working_during_losses
grep '08:00:00 AM'  0312_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' >> Dealers_working_during_losses
grep '02:00:00 PM'  0312_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' >> Dealers_working_during_losses
grep '08:00:00 PM'  0312_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' >> Dealers_working_during_losses
grep '11:00:00 PM'  0312_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' >> Dealers_working_during_losses
grep '05:00:00 AM'  0315_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' >> Dealers_working_during_losses
grep '08:00:00 PM'  0315_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' >> Dealers_working_during_losses
grep '02:00:00 PM'  0315_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' >> Dealers_working_during_losses
