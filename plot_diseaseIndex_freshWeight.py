import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

max_DI = 4
filename = "/Users/like/Downloads/Bioassay_20171120.xlsx"
xl = pd.read_excel(filename, sheetname=None)#, dtype = {"Fresh weight": float})#"Disease Index": int})

isolates = xl.keys()

isolate2color = {}
cmap          = plt.cm.get_cmap('tab10')
for i, isolate in enumerate(isolates):
	isolate2color[isolate] = cmap(0.1*i)

fig = plt.figure()
ax  = plt.gca()
for isolate in isolates:
	df = xl[isolate]
	#pd.to_numeric("Disease Index")

	#print isolate, df
	df.plot(kind = "scatter", x="Disease Index", y="Fresh weight", color=isolate2color[isolate], alpha = 0.5, label = isolate, ax = ax)

#plt.legend(loc='center right')
#plt.show()
#plt.close()

DI2color = {}
colors   = []
di_cmap  = plt.cm.get_cmap('afmhot')
for i in range(max_DI+1):
	DI2color[i] = 1-((i+1)/float(max_DI+1))
	colors.append(di_cmap(1-((i+1)/float(max_DI+1))))

counts = []
for i in range((max_DI+1)): counts.append([])

print counts
for isolate in isolates:
	df = xl[isolate]

	DIvalues = df["Disease Index"].tolist()
	for di in range(0,max_DI+1):
		print isolate, di, DIvalues.count(di)
		counts[di].append(DIvalues.count(di))
		#print counts

print counts
fig = plt.figure()
ax  = plt.gca()

ind    = range(len(isolates))
bottom = np.zeros(len(isolates))

for di in range(0,max_DI+1):
	plt.bar(ind, counts[di], bottom = bottom, color = colors[di], width = 0.5)
	bottom += np.array(counts[di])
	print 'b', bottom

plt.xticks(ind, isolates)
plt.show()




