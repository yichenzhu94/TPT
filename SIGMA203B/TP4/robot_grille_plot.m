function robot_grille_plot(L, walls, thetaObs )
  marg = 2/thetaObs;
  nwalls = size(walls,1) ;
  axis([-marg, L+marg, -marg, L+marg], 'manual' )
  plot(0:L, 0 * ones(1,L+1),  'linewidth', 4, 'color', 'k')
  plot( 0:L, L *  ones(1,L+1), 'linewidth', 4,'color', 'k' )
  plot( 0 *  ones(1,L+1), 0:L, 'linewidth', 4,'color', 'k' )
  plot( L *  ones(1,L+1), 0:L, 'linewidth', 4,'color', 'k' )
  for i = 1:nwalls
    if (walls(i,4) ==1 ) %%horizontal
      line([walls(i,1), walls(i,1) + walls(i,3)], ...
	   [walls(i,2), walls(i,2)],  ...
	   'linewidth', 4)
    else
      line([walls(i,1), walls(i,1) ], ...
        [walls(i,2), walls(i,2)+ walls(i,3)],  ...
	   'linewidth', 4)
    
  end
end 
  val =true;
end
