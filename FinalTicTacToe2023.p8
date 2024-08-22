pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
function _init()
 x = 16
 y = 8 

 game_start = false
 
 board = {
  {0, 0, 0},
  {0, 0, 0},
  {0, 0, 0}
}
 xpos = 1
 ypos = 1
 
 winx3 = 0
 winy3 = 0
 winx4 = 0
 winy4 = 0
 losex3 = 0
 losey3 = 0
 losex4 = 0
 losey4 = 0
 game_over = false
 turn = false
 movecounter = 1
 
end

-->8
function _draw()
 cls()
 
 map(0, 0, 8, 0, 16, 16)
 
 draw_moves() 
 spr(13,x,y,4,4)
-- print(game_over,20,50)
 
 if (game_start == false) then
  spr(68,16,20,4,4)
  spr(68,48,20,4,4)
  spr(68,80,20,4,4)
  spr(68,16,52,4,4)
  spr(68,48,52,4,4)
  spr(68,80,52,4,4)
  print("welcome to tic tac toe!",20,25,0)
  print("use the arrow keys to",22,35,0)
  print("aim your move and  ",29,45,0)
  print("press ❎ to lock it in ",20,55,0)
  
  print("-press 'z' to play-",27,65,1)
  if (btnp(4)) then
   game_start = true
  end
 end
 
 
 
 if checkwin_1() then
  spr(64,30,30,4,4)
  spr(64,65,30,4,4)
  spr(64,35,30,4,4)
  print("player wins!",36,44,0)
  spr(64,30,45,4,4)
  spr(64,65,45,4,4)
  spr(64,35,45,4,4)
  print("z to play again",36,59,0)
  game_over = true
  if (btnp(4)) then
   _init()
  end
 end
 if checkwin_2() then
  spr(64,30,30,4,4)
  spr(64,65,30,4,4)
  spr(64,35,30,4,4)
  print("computer wins!",36,44,0)
  spr(64,30,45,4,4)
  spr(64,65,45,4,4)
  spr(64,35,45,4,4)
  print("z to play again",36,59,0)
  game_over = true
  if (btnp(4)) then
   _init()
  end
 end

 if checkdraw() then
  if not checkwin_1() then
   if not checkwin_2() then
    spr(64,30,30,4,4)
    spr(64,65,30,4,4)
    spr(64,35,30,4,4)
    print("draw!",55,44,0)
    spr(64,30,45,4,4)
    spr(64,65,45,4,4)
    spr(64,35,45,4,4)
    print("z to play again",36,59,0)
    game_over = true
    if (btnp(4)) then
     _init()
    end
   end
  end
 end
 
 
 aim()
 
 if (game_over ==false) then
  if (turn ==false) then
  
   computer()
   xpos = 1
   ypos = 1
   x = 16
   y = 8
   spr(13,x,y)
   
  end
 end
 
 if (game_over ==false) then
  if (turn == true) then
   marker1()
  end
 end

  
  
end	

-->8
function aim()
 if ((game_over == false) and (turn == true)) then
  spr(13,x,y)
  
  if (btnp(1)) then
   x += 32
   xpos += 1
  end
 
  if (btnp(0)) then
   x -= 32
   xpos -=1
  end 
  
  if (btnp(3)) then
   y +=32
   ypos +=1
  end
 
  if (btnp(2)) then
   y -= 32
   ypos -=1
  end
 
  if (x>80) then
   x=80
   xpos =3
  end
  
  if (x<16) then
   x=16
   xpos =1
  end
  
  if (y>72) then
   y = 72
   ypos =3
  end
  
  if (y<8) then
   y = 8
   ypos =1
  end
 end
 
end


-->8
function checkwin_1()
  -- check rows
  for row = 1, 3 do
    if board[row][1] == 1 and board[row][2] == 1 and board[row][3] == 1 then
      return true
    end
  end

  -- check columns
  for col = 1, 3 do
    if board[1][col] == 1 and board[2][col] == 1 and board[3][col] == 1 then
      return true
    end
  end

  -- check diagonals
  if board[1][1] == 1 and board[2][2] == 1 and board[3][3] == 1 then
    return true
  end

  if board[3][1] == 1 and board[2][2] == 1 and board[1][3] == 1 then
    return true
  end

  return false
end

function checkwin_2()
  -- check rows
  for row = 1, 3 do
    if board[row][1] == 2 and board[row][2] == 2 and board[row][3] == 2 then
      return true
    end
  end

  -- check columns
  for col = 1, 3 do
    if board[1][col] == 2 and board[2][col] == 2 and board[3][col] == 2 then
      return true
    end
  end

  -- check diagonals
  if board[1][1] == 2 and board[2][2] == 2 and board[3][3] == 2 then
    return true
  end

  if board[3][1] == 2 and board[2][2] == 2 and board[1][3] == 2 then
    return true
  end

  return false
end

function checkdraw()
  local draw = true
  for t = 1, 3 do
    for r  = 1, 3 do
      if board[t][r] == 0 then
        draw = false
        break
      end
    end
    if not draw then
      break
    end
  end
  return draw
end

-->8
function computer()
 winresult3 = almostwin3()
 winresult4 = almostwin4()
 loseresult3 = almostlose3()
 loseresult4 = almostlose4()
 if (game_over == false) and (turn ==false) then
  
  if (movecounter ==1) then
   
   board[1][1] = 2
  end
 
  if (movecounter ==2) then
   if (board[3][3] ==0) then
    board[3][3] = 2     
   else
    board[3][1] = 2
   end
  end
  
  if (movecounter ==3) then
   if (winresult3 == true) then
    
    board[winx3][winy3] = 2
   
   elseif (loseresult3 == true) then
    board[losex3][losey3] = 2
   
   else
    if (board[3][1] == 0) then
     board[3][1] = 2
    
    elseif (board[1][3] == 0) then
     board[1][3] =2
    end
   end
  end
  
  if (movecounter ==4) then
   
   if (winresult4 == true) then
    
    board[winx4][winy4] = 2
   
   elseif (loseresult4 == true) then
    board[losex4][losey4] = 2
   
   else
    if (board[3][1] == 0) then
     board[3][1] = 2
    
    elseif (board[1][3] == 0) then
     board[1][3] =2
    end
   end
  end
   
  if (movecounter ==5) then
   for row =  1,3 do
    for col =  1,3 do
     if (board[row][col] == 0) then
      board[row][col] =2
     end
    end
   end
  end
  
 turn = true
 
 end
end



-->8
function draw_moves()

 if (board[1][1] == 1) then
  spr(5,16,8,4,4)
 end
 if (board[1][2] == 1) then
  spr(5,48,8,4,4)
 end
 if (board[1][3] == 1) then
  spr(5,80,8,4,4)
 end
 if (board[2][1] == 1) then
  spr(5,16,40,4,4)
 end
 if (board[2][2] == 1) then
  spr(5,48,40,4,4)
 end
 if (board[2][3] == 1) then
  spr(5,80,40,4,4)
 end
 if (board[3][1] == 1) then
  spr(5,16,72,4,4)
 end
 if (board[3][2] == 1) then
  spr(5,48,72,4,4)
 end
 if (board[3][3] == 1) then
  spr(5,80,72,4,4)
 end
 
 --player two moves
  if (board[1][1] == 2) then
  spr(9,16,8,4,4)
 end
 if (board[1][2] == 2) then
  spr(9,48,8,4,4)
 end
 if (board[1][3] == 2) then
  spr(9,80,8,4,4)
 end
 if (board[2][1] == 2) then
  spr(9,16,40,4,4)
 end
 if (board[2][2] == 2) then
  spr(9,48,40,4,4)
 end
 if (board[2][3] == 2) then
  spr(9,80,40,4,4)
 end
 if (board[3][1] == 2) then
  spr(9,16,72,4,4)
 end
 if (board[3][2] == 2) then
  spr(9,48,72,4,4)
 end
 if (board[3][3] == 2) then
  spr(9,80,72,4,4)
 end




 
 
 
end

 
-->8
function marker1()
if (board[ypos][xpos]==0) and (turn ==true) then 
 if (btnp(5)) then
  board[ypos][xpos]=1
  turn = false
  

  movecounter +=1
 end
end
end


-->8
function almostwin3()
  -- check rows
  for row = 1, 3 do
    if board[row][1] == 2 and board[row][2] == 2 and board[row][3] == 0 then
      winx3 = row
      winy3 = 3
      return true
    end
    
    if board[row][1] == 2 and board[row][2] == 0 and board[row][3] == 2 then
      winx3 = row
      winy3 = 2
      
      return true
    end
    
    if board[row][1] == 0 and board[row][2] == 2 and board[row][3] == 2 then
      winx3 = row
      winy3 = 1
      
      return true
    end
  end
  
  -- check columns
  for col = 1, 3 do
    if board[1][col] == 2 and board[2][col] == 2 and board[3][col] == 0 then
      winx3 = 3
      winy3 = col
      
      return true
    end
    
    if board[1][col] == 2 and board[2][col] == 0 and board[3][col] == 2 then
      winx3 = 2
      winy3 = col 
      
      return true
    end
    
    if board[1][col] == 0 and board[2][col] == 2 and board[3][col] == 2 then
      winx3 = 1
      winy3 = col
      
      return true
    end
  end
  
  -- check diagonals
  if board[1][1] == 2 and board[2][2] == 2 and board[3][3] == 0 then
    winx3 = 3
    winy3 = 3
    
    return true
  end
  
  if board[1][1] == 2 and board[2][2] == 0 and board[3][3] == 2 then
    winx3 =2
    winy3 =2
    
    return true
  end
  
  if board[1][3] == 2 and board[2][2] == 2 and board[3][1] == 0 then
    winx3 = 3
    winy3 = 1
    
    return true
  end
  
  if board[1][3] == 2 and board[2][2] == 0 and board[3][1] == 2 then
    winx3 = 2
    winy3 = 2
    
    return true
  end
  
  return false
end

--move 4






function almostwin4()
  -- check rows
  for row = 1, 3 do
    if board[row][1] == 2 and board[row][2] == 2 and board[row][3] == 0 then
      winx4 = row
      winy4 = 3
      return true
    end
    
    if board[row][1] == 2 and board[row][2] == 0 and board[row][3] == 2 then
      winx4 = row
      winy4 = 2
      
      return true
    end
    
    if board[row][1] == 0 and board[row][2] == 2 and board[row][3] == 2 then
      winx4 = row
      winy4 = 1
      
      return true
    end
  end
  
  -- check columns
  for col = 1, 3 do
    if board[1][col] == 2 and board[2][col] == 2 and board[3][col] == 0 then
      winx4 = 3
      winy4 = col
      
      return true
    end
    
    if board[1][col] == 2 and board[2][col] == 0 and board[3][col] == 2 then
      winx4 = 2
      winy4 = col 
      
      return true
    end
    
    if board[1][col] == 0 and board[2][col] == 2 and board[3][col] == 2 then
      winx4 = 1
      winy4 = col
      
      return true
    end
  end
  
  -- check diagonals
  if board[1][1] == 2 and board[2][2] == 2 and board[3][3] == 0 then
    winx4 = 3
    winy4 = 3
    
    return true
  end
  
  if board[1][1] == 2 and board[2][2] == 0 and board[3][3] == 2 then
    winx4 =2
    winy4 =2
    
    return true
  end
  
  if board[1][3] == 2 and board[2][2] == 2 and board[3][1] == 0 then
    winx4 = 3
    winy4 = 1
    
    return true
  end
  
  if board[1][3] == 2 and board[2][2] == 0 and board[3][1] == 2 then
    winx4 = 2
    winy4 = 2
    
    return true
  end
  
  return false
end










-->8
function almostlose3()
  -- check rows
  for row = 1, 3 do
    if board[row][1] == 1 and board[row][2] == 1 and board[row][3] == 0 then
      losex3 = row
      losey3 = 3
      return true
    end
    
    if board[row][1] == 1 and board[row][2] == 0 and board[row][3] == 1 then
      losex3 = row
      losey3 = 2
      
      return true
    end
    
    if board[row][1] == 0 and board[row][2] == 1 and board[row][3] == 1 then
      losex3 = row
      losey3 = 1
      
      return true
    end
  end
  
  -- check columns
  for col = 1, 3 do
    if board[1][col] == 1 and board[2][col] == 1 and board[3][col] == 0 then
      losex3 = 3
      losey3 = col
      
      return true
    end
    
    if board[1][col] == 1 and board[2][col] == 0 and board[3][col] == 1 then
      losex3 = 2
      losey3 = col 
      
      return true
    end
    
    if board[1][col] == 0 and board[2][col] == 1 and board[3][col] == 1 then
      losex3 = 1
      losey3 = col
      
      return true
    end
  end
  
  -- check diagonals
  if board[1][1] == 1 and board[2][2] == 1 and board[3][3] == 0 then
    losex3 = 3
    losey3 = 3
    
    return true
  end
  
  if board[1][1] == 1 and board[2][2] == 0 and board[3][3] == 1 then
    losex3 =2
    losey3 =2
    
    return true
  end
  
  if board[1][3] == 1 and board[2][2] == 1 and board[3][1] == 0 then
    losex3 = 3
    losey3 = 1
    
    return true
  end
  
  if board[1][3] == 1 and board[2][2] == 0 and board[3][1] == 1 then
    losex3 = 2
    losey3 = 2
    
    return true
  end
  
  return false
end

--move 4


function almostlose4()
  -- check rows
  for row = 1, 3 do
    if board[row][1] == 1 and board[row][2] == 1 and board[row][3] == 0 then
      losex4 = row
      losey4 = 3
      return true
    end
    
    if board[row][1] == 1 and board[row][2] == 0 and board[row][3] == 1 then
      losex4 = row
      losey4 = 2
      
      return true
    end
    
    if board[row][1] == 0 and board[row][2] == 1 and board[row][3] == 1 then
      losex4 = row
      losey4 = 1
      
      return true
    end
  end
  
  -- check columns
  for col = 1, 3 do
    if board[1][col] == 1 and board[2][col] == 1 and board[3][col] == 0 then
      losex4 = 3
      losey4 = col
      
      return true
    end
    
    if board[1][col] == 1 and board[2][col] == 0 and board[3][col] == 1 then
      losex4 = 2
      losey4 = col 
      
      return true
    end
    
    if board[1][col] == 0 and board[2][col] == 1 and board[3][col] == 1 then
      losex4 = 1
      losey4 = col
      
      return true
    end
  end
  
  -- check diagonals
  if board[1][1] == 1 and board[2][2] == 1 and board[3][3] == 0 then
    losex4 = 3
    losey4 = 3
    
    return true
  end
  
  if board[1][1] == 1 and board[2][2] == 0 and board[3][3] == 1 then
    losex4 =2
    losey4 =2
    
    return true
  end
  
  if board[1][3] == 1 and board[2][2] == 1 and board[3][1] == 0 then
    losex4 = 3
    losey4 = 1
    
    return true
  end
  
  if board[1][3] == 1 and board[2][2] == 0 and board[3][1] == 1 then
    losex4 = 2
    losey4 = 2
    
    return true
  end
  
  return false
end














__gfx__
77777777666666666666666666666666666666666666666666666666666666666666666600000000000000000000000000000000000000000000000000000000
77777777600000000000000000000000000000066000000000000000000000000000000600000000000000000000000000000000000000000000000000000000
777777776000000000000000000000000000000660800000000000000000000000000806000000000000cccccccc000000000000000000000000000000000000
777777776000000000000000000000000000000660080000000000000000000000008006000000000ccc00000000ccc000000000000000000000000000000000
77777777600000000000000000000000000000066000800000000000000000000008000600000000c00000000000000c00000000000000000000000000000000
7777777760000000000000000000000000000006600008000000000000000000008000060000000c0000000000000000c0000000000000000000000000000000
777777776000000000000000000000000000000660000080000000000000000008000006000000c000000000000000000c000000000000000000000000000000
77777777600000000000000000000000000000066000000800000000000000008000000600000c00000000000000000000c00000000000000000000000000000
0000000060000000000000000000000000000006600000008000000000000008000000060000c0000000000000000000000c000000000000aaaaaaaaaaaaaaaa
000000006000000000000000000000000000000660000000080000000000008000000006000c000000000000000000000000c00000000000aaaaaaaaaaaaaaaa
000000006000000000000000000000000000000660000000008000000000080000000006000c000000000000000000000000c00000000000aa000000000000aa
000000006000000000000000000000000000000660000000000800000000800000000006000c000000000000000000000000c00000000000aa000000000000aa
00000000600000000000000000000000000000066000000000008000000800000000000600c00000000000000000000000000c0000000000aa000000000000aa
00000000600000000000000000000000000000066000000000000800008000000000000600c00000000000000000000000000c0000000000aa000000000000aa
00000000600000000000000000000000000000066000000000000080080000000000000600c00000000000000000000000000c0000000000aa000000000000aa
00000000600000000000000000000000000000066000000000000008800000000000000600c00000000000000000000000000c0000000000aa000000000000aa
00000000600000000000000000000000000000066000000000000008800000000000000600c00000000000000000000000000c0000000000aa000000000000aa
00000000600000000000000000000000000000066000000000000080080000000000000600c00000000000000000000000000c0000000000aa000000000000aa
00000000600000000000000000000000000000066000000000000800008000000000000600c00000000000000000000000000c0000000000aa000000000000aa
00000000600000000000000000000000000000066000000000008000000800000000000600c00000000000000000000000000c0000000000aa000000000000aa
000000006000000000000000000000000000000660000000000800000000800000000006000c000000000000000000000000c00000000000aa000000000000aa
000000006000000000000000000000000000000660000000008000000000080000000006000c000000000000000000000000c00000000000aa000000000000aa
000000006000000000000000000000000000000660000000080000000000008000000006000c000000000000000000000000c00000000000aaaaaaaaaaaaaaaa
0000000060000000000000000000000000000006600000008000000000000008000000060000c0000000000000000000000c000000000000aaaaaaaaaaaaaaaa
00000000600000000000000000000000000000066000000800000000000000008000000600000c00000000000000000000c00000000000000000000000000000
000000006000000000000000000000000000000660000080000000000000000008000006000000c000000000000000000c000000000000000000000000000000
0000000060000000000000000000000000000006600008000000000000000000008000060000000c0000000000000000c0000000000000000000000000000000
00000000600000000000000000000000000000066000800000000000000000000008000600000000c00000000000000c00000000000000000000000000000000
000000006000000000000000000000000000000660080000000000000000000000008006000000000ccc00000000ccc000000000000000000000000000000000
000000006000000000000000000000000000000660800000000000000000000000000806000000000000cccccccc000000000000000000000000000000000000
00000000600000000000000000000000000000066000000000000000000000000000000600000000000000000000000000000000000000000000000000000000
00000000666666666666666666666666666666666666666666666666666666666666666600000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001020304010203040102030400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0011121314111213141112131400000040404040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0021222324212223242122232400000040404040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0031323334313233343132333400000040404040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001020304010203040102030400000040404040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0011121314111213141112131400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0021222324212223242122232400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0031323334313233343132333400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001020304010203040102030400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0011121314111213141112131400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0021222324212223242122232400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0031323334313233343132333400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
