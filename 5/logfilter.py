
logfile = open('logfile.txt', 'r')
lines = logfile.readlines()

# find unique ip's
unique_ips={}
for line in lines:
    ip=line.split(' ')[1]
    if ip in unique_ips:
        print("found")
        unique_ips[ip] = unique_ips[ip] + 1
    else:
        print("not found")
        unique_ips[ip] = 1

# sort in descending order 
sorted_ips = sorted(unique_ips.items(), reverse=True)

print("Unique IP's: ", unique_ips)
print("Sorted IP's: ", sorted_ips)
