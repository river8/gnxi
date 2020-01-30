# eno2
# b = 631
# e = 694
# enp59s0f0
b = 143
e = 247

for irq_no in range(b, e+1):
  i=irq_no-b
  if i>=96:
    continue
  s=hex(1<<i)[2:]
  if s[-1]=='L':
    s=s[:-1]
  v=""
  j=0
  while j<len(s):
    if j and j%8==0:
      v=","+v
    v=s[len(s)-1-j]+v
    j+=1
  print "echo %s > /proc/irq/%s/smp_affinity" % (v, irq_no)
