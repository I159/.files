DOTFILES="$(pwd)"

echo -e "Backup existing dot files"
DATE=$(date +%Y-%m-%d-%T)
mkdir $HOME/.backup_dot_files-$DATE

if [ -L $HOME/.gitconfig ]
then
	rm -f $HOME/.gitconfig
else
	mv -f $HOME/.gitconfig $HOME/.backup_dot_files
fi

if [ -L $HOME/.bashrc ]
then
	rm -f $HOME/.bashrc
else
	mv -f $HOME/.bashrc $HOME/.backup_dot_files
fi

echo "Installing .git-prompt.sh"
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.git-prompt.sh

echo -e "Create symbolic links to dot files"
ln -s $DOTFILES/.gitconfig $HOME/.gitconfig
ln -s $DOTFILES/.bashrc $HOME/.bashrc
