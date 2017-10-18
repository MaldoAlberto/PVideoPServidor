----------------------------------------------------------------------
-- This script shows how to train different models on the CIFAR
-- dataset, using multiple optimization techniques (SGD, ASGD, CG)
--
-- This script demonstrates a classical example of training
-- well-known models (convnet, MLP, logistic regression)
-- on a 10-class classification problem.
--
-- It illustrates several points:
-- 1/ description of the model
-- 2/ choice of a loss function (criterion) to minimize
-- 3/ creation of a dataset as a simple Lua table
-- 4/ description of training and test procedures
--
-- Clement Farabet
----------------------------------------------------------------------

require 'torch'
require 'nn'

require 'nnx'
require 'dok'
require 'image'
--require 'cudnn'
require 'torch'   -- torch
require 'xlua'    -- xlua provides useful tools, like progress bars
require 'optim'   -- an optimization package, for online and batch methods

----------------------------------------------------------------------
-- set options
print ("modelo 1");
au = false
-- fix seed
torch.manualSeed(1)
-- set number of threads
torch.setnumthreads(8)
--torch.setdefaulttensortype('torch.DoubleTensor')
--torch.setdefaulttensortype('torch.FloatTensor')
-- classname for cifar 10
classes={'caricatura','documental','futbol','guerra','noticias','novela' }

--print('load pretrained network file')

--network=torch.load('results/model.net')
model=torch.load('a.bin')

--network=torch.load('results/model.net')
--cudnn.convert(network, nn)
--model= network:float()
model:evaluate()
torch.save('a.bin', model)


--model=torch.load('sillas_float.bin')
--model= network:cuda()

   --model:evaluate()
--model=torch.load('model.net')
--torch.save('cifar.net.ascii', model, 'ascii')


--model=torch.load('cifar.net.ascii', 'ascii')
--torch.save('cifar.net.bi', model, 'binary')
--model=torch.load('cifar.net.bi')


parameters,gradParameters = model:getParameters()

--model:add(nn.LogSoftMax())
criterion = nn.ClassNLLCriterion()

-- read mean & std values
mean_y=torch.load('mean_y_videos')
mean_u=torch.load('mean_u_videos')
mean_v=torch.load('mean_v_videos')

std_y=torch.load('std_y_videos')
std_u=torch.load('std_u_videos')
std_v=torch.load('std_v_videos')


--	print '==> here is the model:'
--	print(model)

--model:add(nn.SoftMax())
-- function for test image
function getRecogResult(sampledata)
   model:evaluate()

  data = sampledata--:reshape(3,32,32)

 -- data = torch.DoubleTensor():set(sampledata)

data=data:float()
image.saveJPG('entrada0.jpg',data)
--data=sampledata:cuda()
neighborhood = image.gaussian1D(13)
  normalization = nn.SpatialContrastiveNormalization(1, neighborhood, 1):float()


--[[
  local rgb = data

  local yuv = image.rgb2yuv(rgb)



  -- print 'normalize y locally'
  yuv[1] = normalization(yuv[{{1}}])
  data = yuv

]]--
channels = {'y','u','v'}

  local foto = image.rgb2yuv(data)

 
  foto[{ 1,{},{} }]:add(-mean_y)
  foto[{ 1,{},{} }]:div(std_y)

  foto[{ 2,{},{} }]:add(-mean_u)
  foto[{ 2,{},{} }]:div(std_u)

  foto[{ 3,{},{} }]:add(-mean_v)
  foto[{ 3,{},{} }]:div(std_v)


for c in ipairs(channels) do

      foto[{ {c},{},{} }] = normalization:forward(foto[{{c},{},{} }])

end





image.saveJPG('entarada1.jpg',foto)

  local result = model:forward(foto)
  return result
end

function getTopOnly(sampledata)



--sampledata=image.load(imname)


 
local result = getRecogResult(sampledata)
local max
local index = 0
  
for k=1,5 do
if max == nil or max < result[k] then
index = k
max = result[k]

end
--print('  '..result[k])
end
return index
--[=====[ 
--]=====] 
end


tam_frames = 1
epoca = 40
caricaturaP = 0
futbolP = 0
guerraP = 0
noticiaP = 0
novelaP = 0
--i=1

v = torch.Tensor(1,tam_frames):zero()
classes={'caricatura','documental','futbol','guerra','noticias','novela' }
--while i<2 do
for i=1,tam_frames do
entrada = '/home/alberto/Desktop/servidor/profile.png'
--[[io.write("input name : ")
	io.flush()
	entrada=io.read()
	print(entrada)]]--
	I = image.load(entrada)
	--res=image.y2jet(torch.linspace(1,10,10))
--		image.rgb2yuv(res, im)
--I=image.load(imname)
--image.display(I)
I = I:resize(3,32,32)

salida=getTopOnly(I)	
--print(salida)
aux = model

	if salida==1 then
	print(i..' caricatura')
	caricaturaP = caricaturaP + 1 

	elseif  salida==2 then
	print(i..' documental') 
	futbolP = futbolP + 1 

	elseif  salida==3 then
	print(i..' futbol') 
	futbolP = futbolP + 1 

	elseif  salida==4 then
	print(i..' guerra') 
	guerraP = guerraP + 1

	elseif  salida==5 then
	print(i..' noticias')
	noticiaP = noticiaP + 1
 
	elseif  salida==6 then
	print(i..' novela') 
	novelaP = novelaP + 1 

	else
	print('error')
	end
name = salida;
--print(name..'toto')

v:indexFill(2,torch.LongTensor{i,1},salida)
i = i+1
end






