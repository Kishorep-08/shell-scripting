# #!/bin/bash

# ##Script to print each line one by one in a file

# while read content      #each line is stored in content and printed
# do
#     echo "Line is: $content"
# done < file-1.txt       #this is the file. It will be considered input



while IFS= read -r line
do
    echo "Line is: $line"
done < file-2.txt

# for line in $(cat file-2.txt)
# do
#     echo "Line is: $line"
# done