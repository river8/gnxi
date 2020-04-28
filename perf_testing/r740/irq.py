start = 696
end = 759

def helper(s):
  s=str(s)
  t=s[::-1]
  print t
  i=0
  tt=""
  while i<len(t):
   tt=tt+t[i:8]
   print tt
   if i+8<len(t):
     tt=tt+","
     break
   i=i+8
  return tt[::-1]

suffix = ""
while start <= end:
  for p in [1, 2, 4, 8]:
    val = '%s%s' % (p, suffix)
    val=helper(val)
    print 'echo %s > /proc/irq/%s/smp_affinity' % (val, start)
    start += 1
  suffix = "0" + suffix
