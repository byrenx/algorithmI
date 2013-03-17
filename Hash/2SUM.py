from collections import defaultdict

ht=defaultdict(int)
a=2500
b=4000

for number in open("HashInt.txt").read().strip().split("\n"):
    number = int(number)
    if(number < b):
        ht[number] = ht[number] + 1

SUM = []
for target in range(a, b+1):
    for number in ht.keys():
        if number*2 == target and ht[number] > 2:
            SUM = SUM + [target]
            break
        elif  number*2 !=target  and (ht.has_key(target-number)): 
            SUM = SUM + [target]
            break
            
            


