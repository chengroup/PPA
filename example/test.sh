ustacks -f ./RAD/C1.1.fa.gz -o ./out_dir/ustacks -i 1 --name C1 -m 3 -M 2 --max-locus-stacks 10
ustacks -f ./RAD/P1.1.fa.gz -o ./out_dir/ustacks -i 2 --name P1 -m 3 -M 2 --max-locus-stacks 10
ustacks -f ./RAD/P2.1.fa.gz -o ./out_dir/ustacks -i 3 --name P2 -m 3 -M 2 --max-locus-stacks 10
ustacks -f ./RAD/P3.1.fa.gz -o ./out_dir/ustacks -i 4 --name P3 -m 3 -M 2 --max-locus-stacks 10
zcat ./out_dir/ustacks/C1.tags.tsv.gz > ./out_dir/ustacks/C1.tags.tsv
zcat ./out_dir/ustacks/P1.tags.tsv.gz > ./out_dir/ustacks/P1.tags.tsv
zcat ./out_dir/ustacks/P2.tags.tsv.gz > ./out_dir/ustacks/P2.tags.tsv
zcat ./out_dir/ustacks/P3.tags.tsv.gz > ./out_dir/ustacks/P3.tags.tsv

./extract_seq -i ./out_dir/ustacks/C1.tags.tsv -o ./out_dir/primary_fa/C1.primary.fasta
./extract_seq -i ./out_dir/ustacks/P1.tags.tsv -o ./out_dir/primary_fa/P1.primary.fasta
./extract_seq -i ./out_dir/ustacks/P2.tags.tsv -o ./out_dir/primary_fa/P2.primary.fasta
./extract_seq -i ./out_dir/ustacks/P3.tags.tsv -o ./out_dir/primary_fa/P3.primary.fasta

./fa_merge -i ./out_dir/primary_fa/C1.primary.fasta ./out_dir/primary_fa/P1.primary.fasta -o ./out_dir/merge_fa/C1P1.fasta
./fa_merge -i ./out_dir/primary_fa/C1.primary.fasta ./out_dir/primary_fa/P2.primary.fasta -o ./out_dir/merge_fa/C1P2.fasta
./fa_merge -i ./out_dir/primary_fa/C1.primary.fasta ./out_dir/primary_fa/P3.primary.fasta -o ./out_dir/merge_fa/C1P3.fasta

ustacks -f ./out_dir/merge_fa/C1P1.fasta -o ./out_dir/fa_ustacks -i 12 --name C1P1 -m 1 -M 2 --max-locus-stacks 10 -t fasta
ustacks -f ./out_dir/merge_fa/C1P2.fasta -o ./out_dir/fa_ustacks -i 13 --name C1P2 -m 1 -M 2 --max-locus-stacks 10 -t fasta
ustacks -f ./out_dir/merge_fa/C1P3.fasta -o ./out_dir/fa_ustacks -i 14 --name C1P3 -m 1 -M 2 --max-locus-stacks 10 -t fasta

./tags_filter -i ./out_dir/fa_ustacks/C1P1.tags.tsv -o ./out_dir/fa_ustacks/C1P1.tags.tsv.clean
./tags_filter -i ./out_dir/fa_ustacks/C1P2.tags.tsv -o ./out_dir/fa_ustacks/C1P2.tags.tsv.clean
./tags_filter -i ./out_dir/fa_ustacks/C1P3.tags.tsv -o ./out_dir/fa_ustacks/C1P3.tags.tsv.clean

./extract_intersection -i 1 -l ./out_dir/fa_ustacks/C1P1.tags.tsv.clean ./out_dir/fa_ustacks/C1P2.tags.tsv.clean ./out_dir/fa_ustacks/C1P3.tags.tsv.clean -s .intersection

./LOD -i ./out_dir/fa_ustacks/C1P1.tags.tsv.clean.intersection -l 145 -er 0.0024 -he 0.001
./LOD -i ./out_dir/fa_ustacks/C1P2.tags.tsv.clean.intersection -l 145 -er 0.0024 -he 0.001
./LOD -i ./out_dir/fa_ustacks/C1P3.tags.tsv.clean.intersection -l 145 -er 0.0024 -he 0.001