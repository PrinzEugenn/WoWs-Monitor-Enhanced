(() => {
  const values=[
    ['Alpha',58,3820,60,240,2300],['Bravo',53,2600,55,120,1700],['Charlie',50,1400,50,110,1400],['Delta',49.9,1300,49.9,100,1000],['Echo',54,2100,40,10,700],['Foxtrot',51,1200,51,145,1350],['Golf',56,6000,57,140,1900],['Hotel',48,2200,49,140,900],['India',52,3300,53,110,1550],['Juliet',54,4500,55,150,1800],['Kilo',47,1800,45,130,750],['Lima',55,3300,56,200,2000],
    ['Mike',57,4800,58,210,2150],['November',52,2300,51,140,1500],['Oscar',49,2100,48,120,900],['Papa',50,1400,50,110,1300],['Quebec',55,2800,54,90,1750],['Romeo',48,3100,48,150,850],['Sierra',53,4000,54,130,1700],['Tango',51,2300,52,115,1450],['Uniform',46,2100,47,110,700],['Victor',56,5200,58,200,2050],['Whisky',54,3500,52,120,1600],['Xray',49,2600,50,120,1000]
  ];
  const ships=['Yamato','Montana','Des Moines','Zao','Hindenburg','Gearing','Shimakaze','Kremlin','Vermont','Worcester','Daring','Halland'];
  function stat(w,b,pr){return {winrate:w,battles:b,wins:Math.round(w*b/100),personalRating:pr,personalRatingColor:pr>=2100?'#c58af9':pr>=1750?'#58a5f4':pr>=1550?'#59c9a8':pr>=1350?'#78c947':pr>=1100?'#e1cc45':pr>=750?'#e69a36':'#e35656',winrateColor:w>=55?'#77c85a':w>=50?'#e0cb4c':'#e45f58',battlesColor:'#ddd',averageDamage:Math.round(pr*55),averageDamageColor:'#ccc',averageFrags:1.1,averageFragsColor:'#ccc',averageXp:1600}}
  const players=values.map(([name,a,ab,wr,b,pr],i)=>{const overall=stat(a,ab,pr),ship=stat(wr,b,pr);return {accountId:900000+i,name,region:0,relation:i===0?0:1,bot:false,hidden:false,shipInfo:{name:ships[i%ships.length],tier:10,testship:false},overallStats:overall,soloOverallStats:overall,shipStats:ship,soloShipStats:ship,karma:0}});
  const avg={shipWinrate:52,overallWinrate:52,weightedShipWinrate:52,weightedOverallWinrate:52,medianShipWinrate:52,medianOverallWinrate:52,shipBattles:140,overallBattles:2800,shipXp:1600,overallXp:1500};
  window.__mockMatch={id:'simulation',matchGroup:1,statsUnavailable:false,map:{name:'模拟对局'},friendly:players.slice(0,12),enemy:players.slice(12),friendlyTeam:avg,friendlyTeamSolo:avg,enemyTeam:avg,enemyTeamSolo:avg};
})();
