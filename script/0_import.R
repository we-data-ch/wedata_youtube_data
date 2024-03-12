# Libraries ----
pacman::p_load(tidyverse, GGally, janitor,
               FactoMineR, factoextra)

# Options ----

# data ----
raw_data <- 
  read_csv("data/2024_03_11_wedata.csv") %>% 
  slice(-1) %>% 
  clean_names() %>% 
  select(-contenu) %>% 
  mutate(heure_de_publication_de_la_video = mdy(heure_de_publication_de_la_video))

# Exploration ----
my_mat <- 
  raw_data %>% 
  rename_with(~str_remove(.x, "duree_de_visionnage_")) %>% 
  rename_with(~strtrim(.x, 15)) %>% 
  column_to_rownames("titre_de_la_vid") %>% 
  mutate_all(scale)

# Principal component analysis ----
my_pca <- PCA(my_mat)

# Hierarhical Clustering for Pincipal Component
my_hcpc <- HCPC(my_pca, nb.clust = -1)

fviz_cluster(my_hcpc)
