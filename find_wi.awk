BEGIN {
  getline
  req_p["for_buggy_sun_awk"]=0;  for ( i=1; i<=NF; i++ )  {req_p[$i]=1}
  getline
  for ( i=1; i<=NF; i++ )  {dir_p[$i]=1}
  k="NONE"
  kscore=0
# delete <array> doesn't work with sun awk ...
  U=0
}

{
  split($0,a1,"_")
  split(a1[2],a2,"-")
  U++;  for (i in a2) {cand_p[a2[i]]=U}
  for (i in req_p)  { if ( (req_p[i]==1) && (cand_p[i]!=U) )  {next} }
  if ( (dir_p["gcc"]==1) && (cand_p["suncc"]==U) && (req_p["suncc"]!=1) )  {next}
  if ( (dir_p["suncc"]==1) && (cand_p["gcc"]==U) && (req_p["gcc"]!=1) )  {next}
  score=1
  if (cand_p["shared"]==U)     {score+=3}
  if (cand_p["optimized"]==U)  {score+=3}
  for (i in dir_p)  { if ( (dir_p[i]==1) && (cand_p[i]==U) ) score++ }

  if ( score > kscore )  {k=$0; kscore=score}
}

END {print(k)}
