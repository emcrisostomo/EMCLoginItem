all : EMCLoginItem.pkg

EMCLoginItem.pkg : /tmp/EMCLoginItem.dst requirements.plist EMCLoginItem.plist EMCLoginItemComponent.pkg distribution.dist
	productbuild --distribution distribution.dist --resources . --package-path . EMCLoginItem.pkg

/tmp/EMCLoginItem.dst :
	xcodebuild install

EMCLoginItem.plist :
	pkgbuild --analyze --root /tmp/EMCLoginItem.dst EMCLoginItem.plist

EMCLoginItemComponent.pkg :
	pkgbuild --root /tmp/EMCLoginItem.dst --component-plist EMCLoginItem.plist EMCLoginItemComponent.pkg

distribution.dist :
	productbuild --synthesize --product requirements.plist --package EMCLoginItemComponent.pkg distribution.dist

clean :
	-rm -f EMCLoginItem.pkg EMCLoginItemComponent.pkg
	-rm -rf /tmp/EMCLoginItem.dst

distclean :
	-rm -f distribution.dist EMCLoginItem.plist
