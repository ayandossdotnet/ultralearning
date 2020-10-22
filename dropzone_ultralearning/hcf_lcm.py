def find_hcf(x, y): 
    while(y): 
        x, y = y, x % y 
  
    return x 

def find_lcm(num1, num2): 
    if(num1>num2): 
        num = num1 
        den = num2 
    else: 
        num = num2 
        den = num1 
    rem = num % den 
    while(rem != 0): 
        num = den 
        den = rem 
        rem = num % den 
    hcf = den 
    lcm = int(int(num1 * num2)/int(hcf)) 
    return lcm 
      
l = num = [int(x) for x in input("Enter any numbers sep by comma: ").split(',')]
  
num1 = l[0] 
num2 = l[1] 

lcm = find_lcm(num1, num2) 
hcf = find_hcf(num1, num2)
  
for i in range(2, len(l)): 
    lcm = find_lcm(lcm, l[i])
    hcf = find_hcf(hcf,l[i]) 
      
print('''LCM of {} - {}'''.format(num, lcm))
print('''HCF of {} - {}'''.format(num, hcf))