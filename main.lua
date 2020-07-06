
local fisica = require("physics");
fisica.start();
fisica.setDrawMode( "hybrid" );

-- Activate multitouch
system.activate( "multitouch" );

display.setStatusBar( display.HiddenStatusBar );

_w = display.viewableContentWidth;
_h = display.viewableContentHeight;

-- Criando Background
local fundo = display.newGroup();
local fundo 2 = 5;
-- Fundo
local bg1 = display.newImageRect( "images/Backgrounds/colored_desert.png", _w, _w);
bg1.anchorX = -_w/2;
bg1.x = 0;
bg1.y = _h/2;

local bg2 = display.newImageRect( "images/Backgrounds/colored_grass.png", _w, _w);
bg2.anchorX = -_w/2;
bg2.x = bg1.width;
bg2.y = _h/2;

local bg3 = display.newRect(0, 0, 0, _h*2);
fisica.addBody( bg3, "static");

-- Joystick
local joyL = display.newImageRect( "images/transparentDark/transparentDark22.png", 50, 50);
joyL.x = 50;
joyL.y = _h-70;

local joyR = display.newImageRect( "images/transparentDark/transparentDark23.png", 50, 50);
joyR.x = 120;
joyR.y = _h-70;

local joyUp = display.newImageRect( "images/transparentDark/transparentDark24.png", 50, 50);
joyUp.x = _w - 50;
joyUp.y = _h-70;

local joyKnife = display.newImageRect( "images/transparentDark/transparentDark34.png", 50, 50);
joyKnife.x = _w - 50;
joyKnife.y = _h - 140;

local joyFire = display.newImageRect( "images/transparentDark/transparentDark47.png", 50, 50);
joyFire.x = _w - 100;
joyFire.y = _h - 105;

fundo:insert( bg1 );
fundo:insert( bg2 );
fundo:insert( bg3 );
fundo:insert( joyL );
fundo:insert( joyKnife );

local chao = display.newImageRect("images/Other/grass.png", _w, 30);
chao.x = (_w/2);
chao.y = _h-15;
chao.objType = "chao";
fisica.addBody( chao, "static", { bounce = 0.0, friction = 0.3 } );

local soundLaser = audio.loadSound("sounds/fire.wav");
local soundJump = audio.loadSound("sounds/jump2.wav");
local soundKnife = audio.loadSound("sounds/faca.wav");

-- Personagem utilizando Sprite
local opcoesSprite = {
	width = 94,			-- Largura do frame
	height = 64,		-- Altura do frame
	numFrames = 110		-- Numero de frames
};

local sheet = graphics.newImageSheet("images/sheet_M.png", opcoesSprite);


local seq = { -- Sequências
	{
		name = "paradoDir",			-- Nome da sequência
		start = 91,					-- Quadro inicial
		count = 1,					-- Quantidade de quadros
		time = 700,					-- Duração da animação de 1 loop
		loopCount = 0,				-- Quantidade de loops (0 é inifinito)
		loopDirection = "forward"	-- Direção da animação (forward)
	},
	{
		name = "paradoEsq",			-- Nome da sequência
		start = 99,					-- Quadro inicial
		count = 1,					-- Quantidade de quadros
		time = 700,					-- Duração da animação de 1 loop
		loopCount = 0,				-- Quantidade de loops (0 é inifinito)
		loopDirection = "forward"	-- Direção da animação (forward)
	},
	{
		name = "correrDir",			-- Nome da sequência
		start = 65,					-- Quadro inicial
		count = 8,					-- Quantidade de quadros
		time = 700,					-- Duração da animação de 1 loop
		loopCount = 0,				-- Quantidade de loops (0 é inifinito)
		loopDirection = "forward"	-- Direção da animação (forward)
	},
	{
		name = "correrEsq",			-- Nome da sequência
		start = 73,					-- Quadro inicial
		count = 8,					-- Quantidade de quadros
		time = 700,					-- Duração da animação de 1 loop
		loopCount = 0,				-- Quantidade de loops (0 é inifinito)
		loopDirection = "forward"	-- Direção da animação (forward)
	},
	{	
		name = "pularDir",			-- Nome da sequência
		start = 55,					-- Quadro inicial
		count = 1,					-- Quantidade de quadros
		time = 700,					-- Duração da animação de 1 loop
		loopCount = 0,				-- Quantidade de loops (0 é inifinito)
		loopDirection = "forward"	-- Direção da animação (forward)
	},
	{	
		name = "pularEsq",			-- Nome da sequência
		start = 56,					-- Quadro inicial
		count = 1,					-- Quantidade de quadros
		time = 700,					-- Duração da animação de 1 loop
		loopCount = 0,				-- Quantidade de loops (0 é inifinito)
		loopDirection = "forward"	-- Direção da animação (forward)
	},
	{
		name = "facaDir",			-- Nome da sequência
		start = 83,					-- Quadro inicial
		count = 4,					-- Quantidade de quadros
		time = 50,					-- Duração da animação de 1 loop
		loopCount = 1,				-- Quantidade de loops (0 é inifinito)
		loopDirection = "forward"	-- Direção da animação (forward)
	},
	{
		name = "facaEsq",			-- Nome da sequência
		start = 87,					-- Quadro inicial
		count = 4,					-- Quantidade de quadros
		time = 50,					-- Duração da animação de 1 loop
		loopCount = 1,				-- Quantidade de loops (0 é inifinito)
		loopDirection = "forward"	-- Direção da animação (forward)
	},
	{
		name = "tiroDir",			-- Nome da sequência
		start = 21,					-- Quadro inicial
		count = 2,					-- Quantidade de quadros
		time = 1000,					-- Duração da animação de 1 loop
		loopCount = 0,				-- Quantidade de loops (0 é inifinito)
		loopDirection = "forward"	-- Direção da animação (forward)
	},
	{
		name = "tiroEsq",			-- Nome da sequência
		start = 23,					-- Quadro inicial
		count = 2,					-- Quantidade de quadros
		time = 1000,					-- Duração da animação de 1 loop
		loopCount = 0,				-- Quantidade de loops (0 é inifinito)
		loopDirection = "forward"	-- Direção da animação (forward)
	},
}

local ted = display.newSprite(sheet, seq);
ted.x = _w/2;
ted.y = _h-(55);
local shapeTed = {
	-15, -27,
	18, -27,
	12, 30,
	-12, 30
};
fisica.addBody(ted, "dynamic",
	{ shape = shapeTed, density = 1.0, bounce = 0.1 },
	{ box = { halfWidth = 30, halfHeight = 10, x = 0, y = 60 }, isSensor = true }
); -- Adicionando Fisica

ted.isFixedRotation = true;
ted.sensorOverlaps = 0;

ted:setSequence("paradoDir");
ted:setFrame(1);

local direc = 0;
local veloc = 5;
local acoes = 0;

-- ################## Botões #######################################
-- Andar para a Direita
local function acaoRigth(ev)
	if(ev.phase == "began")then
		direc = 1;
		ted:setSequence("correrDir");
		ted:setFrame(1);
		acoes = 1;
	elseif ( ev.phase == "ended" ) then
		if ( direc == 1 ) then
			ted:setSequence("paradoDir");
			ted:setFrame(1);
		end
		direc = 0;
	end
	ted:play();
end
joyR:addEventListener("touch", acaoRigth);

-- Andar para a Esquerda
local function acaoLeft(ev)
	if(ev.phase == "began")then
		direc = -1;
		ted:setSequence("correrEsq");
		ted:setFrame(1);
		acoes = -1;
	elseif ( ev.phase == "ended" ) then
		if (direc == -1) then
			ted:setSequence("paradoEsq");
			ted:setFrame(1);
		end
		direc = 0;
	end
	ted:play();
end
joyL:addEventListener("touch", acaoLeft);

-- Pular
local function acaoPular(ev)

	local dir, esq = 2;
	
	if(ev.phase == "began")then
		if( ted.sensorOverlaps > 0 )then
			local vx, vy = ted:getLinearVelocity();
			ted:setLinearVelocity( vx, vy );
			ted:applyLinearImpulse( 0, -12, ted.x, ted.y );
			if(acoes == 0)then
				ted:setSequence("pularDir");
				ted:setFrame(1);
				audio.play( soundJump );
			elseif (acoes == 1) then
				ted:setSequence("pularDir");
				ted:setFrame(1);
				audio.play( soundJump );
			elseif (acoes == -1) then
				ted:setSequence("pularEsq");
				ted:setFrame(1);
				audio.play( soundJump );
			end
		end
		
	elseif ( ev.phase == "ended" ) then
		if(acoes == 0)then
			ted:setSequence("paradoDir");
			ted:setFrame(1);
		elseif (acoes == 1) then
			ted:setSequence("paradoDir");
			ted:setFrame(1);
		elseif (acoes == -1) then
			ted:setSequence("paradoEsq");
			ted:setFrame(1);
		end
	end
	
	ted:play();
	
end
joyUp:addEventListener("touch", acaoPular);

-- Facada
local function acaoFacada(ev)
	if(ev.phase == "began")then
		if( acoes == 0 )then
			ted:setSequence("facaDir");
			ted:setFrame(1);
			audio.play( soundKnife );
		elseif (acoes == 1) then
			ted:setSequence("facaDir");
			ted:setFrame(1);
			audio.play( soundKnife );
		elseif(acoes == -1)then
			ted:setSequence("facaEsq");
			ted:setFrame(1);
			audio.play( soundKnife );
		end
	elseif ( ev.phase == "ended" ) then
		if(acoes == 0)then
			ted:setSequence("paradoDir");
			ted:setFrame(1);
		elseif (acoes == 1) then
			ted:setSequence("paradoDir");
			ted:setFrame(1);
		elseif (acoes == -1) then
			ted:setSequence("paradoEsq");
			ted:setFrame(1);
		end
	end
	ted:play();
end
joyKnife:addEventListener("touch", acaoFacada);

local function fireLaserRigth()
	local tam = 65;
	local alt = 32;

	local newLaser = display.newImageRect( "images/laserRigth.png", tam, alt );
	newLaser.x = ted.x + tam;
	newLaser.y = ted.y + 7;
	fundo:insert(newLaser);
	fisica.addBody( newLaser, "static");
	
	audio.play( soundLaser );
	
	transition.to( newLaser, { x = _w, y = ted.y, time = 500,
        onComplete = function() display.remove( newLaser ) end
    } );
end

local function fireLaserLeft()
	local tam = 65;
	local alt = 32;

	local newLaser = display.newImageRect( "images/laserLeft.png", tam, alt );
	newLaser.x = ted.x - tam;
	newLaser.y = ted.y + 7;
	fundo:insert(newLaser);
	fisica.addBody( newLaser, "static");
	
	audio.play( soundLaser );
	
	transition.to( newLaser, { x = -_w, y = ted.y, time = 2000,
        onComplete = function() display.remove( newLaser ) end
    } );
end

-- Tiro
local function acaoTiro(ev)
	if(ev.phase == "began")then
		if( acoes == 0 )then
			ted:setSequence("tiroDir");
			ted:setFrame(1);
			fireLaserRigth();
		elseif (acoes == 1) then
			ted:setSequence("tiroDir");
			ted:setFrame(1);
			fireLaserRigth();
		elseif(acoes == -1)then
			ted:setSequence("tiroEsq");
			ted:setFrame(1);
			fireLaserLeft();
		end
	elseif ( ev.phase == "ended" ) then
		if(acoes == 0)then
			ted:setSequence("paradoDir");
			ted:setFrame(1);
		elseif (acoes == 1) then
			ted:setSequence("paradoDir");
			ted:setFrame(1);
		elseif (acoes == -1) then
			ted:setSequence("paradoEsq");
			ted:setFrame(1);
		end
	end
end
joyFire:addEventListener("touch", acaoTiro);

--  Enter frame para movimentação
local function vigiaEnterFrame(ev)
	if ( direc == 1 or direc == -1 ) then
		ted.x = ted.x + (veloc * direc);
	end
end
Runtime:addEventListener("enterFrame", vigiaEnterFrame);


-- ##################### COLISÕES #####################
local function sensorCollide( self, event )
    if ( event.selfElement == 2 and event.other.objType == "chao" ) then
        if ( event.phase == "began" ) then
            self.sensorOverlaps = self.sensorOverlaps + 1
        elseif ( event.phase == "ended" ) then
            self.sensorOverlaps = self.sensorOverlaps - 1
        end
    end
end
ted.collision = sensorCollide;
ted:addEventListener( "collision" );

















