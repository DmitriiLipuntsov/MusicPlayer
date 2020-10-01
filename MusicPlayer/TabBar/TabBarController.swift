//
//  TabBarController.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 18.08.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import UIKit
import SDWebImage

class TabBarController: UITabBarController {
    
    private var trackView = TabBarTrackView()
    var router: RouterProtocol?
    var tracks: [TrackModel.Track]?
    var index: Int = 0
    var player = Player.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = #colorLiteral(red: 0.9889323115, green: 0.1831878126, blue: 0.3349292278, alpha: 1)
        setTrackBar()
        creatButtonsActions()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerDidFinishPlaying),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: nil)
        trackView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                              action: #selector(trackViewPressed)))
    }
    
    func setupTrack(tracks: [TrackModel.Track], index: Int) {
        self.tracks = tracks
        self.index = index
        setTrack(track: tracks[index])
    }
    
    func setImageForPlayButton() {
        if player.isPlaying {
            trackView.trackControlView.playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        } else {
            trackView.trackControlView.playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
    }
    
    private func setTrackBar() {
        view.addSubview(trackView)
        trackView.translatesAutoresizingMaskIntoConstraints = false
        trackView.backgroundColor = .systemGroupedBackground
        
        trackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        trackView.bottomAnchor.constraint(equalTo: tabBar.topAnchor , constant: -1).isActive = true
        trackView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        trackView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    private func setTrack(track: TrackModel.Track?) {
        trackView.trackNameLabel.text = track?.trackName
        trackView.artistNameLabel.text = track?.artistName
        trackView.artistNameLabel.isHidden = false
        let string600 = track?.iconUrlString?.replacingOccurrences(of: "100x100", with: "600x600")
        guard let url = URL(string: string600 ?? "") else { return }
        trackView.trackImageView.sd_setImage(with: url)
        trackView.trackControlView.playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
    }
    
    //MARK: - ButtonsActions
    
    private func creatButtonsActions() {
        
        trackView.trackControlView.previousTrackButton.addTarget(
            self,
            action: #selector(previousTrackButtonPressed),
            for: .touchUpInside
        )
        
        trackView.trackControlView.playPauseButton.addTarget(
            self,
            action: #selector(playPouseButtonPressed),
            for: .touchUpInside
        )
        
        trackView.trackControlView.nextTrackButton.addTarget(
            self,
            action: #selector(nextTrackButtonPressed),
            for: .touchUpInside
        )
    }
    
    //MARK: - Track control buttons actions
    
    @objc func previousTrackButtonPressed() {
        nextTrack(isNextTrack: false)
    }
    
    @objc func playPouseButtonPressed() {
        if player.avPlayer.timeControlStatus == .paused {
            player.avPlayer.play()
            player.isPlaying = true
            trackView.trackControlView.playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        } else {
            player.avPlayer.pause()
            player.isPlaying = false
            trackView.trackControlView.playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
    }
    
    @objc func nextTrackButtonPressed() {
        nextTrack(isNextTrack: true)
    }
    
    private func nextTrack(isNextTrack: Bool) {
        guard let tracks = tracks else { return }
                if isNextTrack {
                index += 1
                if tracks.count - 1 < index {
                    index = 0
                }
            } else {
                index -= 1
                if index == -1 {
                    index = tracks.count - 1
                }
            }
            
        setTrack(track: tracks[index])
        player.playTrack(previewUrl: tracks[index].previewUrl)
        transferIndexInTableView(tracks: tracks)
    }
    
    private func transferIndexInTableView(tracks: [TrackModel.Track]) {
        if (selectedViewController as! UINavigationController).topViewController is SearchViewController {
            if tracks == ((selectedViewController as! UINavigationController).topViewController as! SearchViewController).presenter.foundTracks {
                ((selectedViewController as! UINavigationController).topViewController as! SearchViewController).selectedRow = index
            }
        } else if (selectedViewController as! UINavigationController).topViewController is LibraryViewController {
            if tracks == ((selectedViewController as! UINavigationController).topViewController as! LibraryViewController).presenter?.tracks {
                ((selectedViewController as! UINavigationController).topViewController as! LibraryViewController).selectedRow = index
            }
        }
    }
    
    private func transferIndexInTableView1(tracks: [TrackModel.Track]) {
            if tracks == ((selectedViewController as? UINavigationController)?.topViewController as! SearchViewController).presenter.foundTracks {
                ((selectedViewController as! UINavigationController).topViewController as! SearchViewController).selectedRow = index
            } else if tracks == ((selectedViewController as? UINavigationController)?.topViewController as! LibraryViewController).presenter?.tracks {
                ((selectedViewController as! UINavigationController).topViewController as! LibraryViewController).selectedRow = index
            }
        
    }
    
    @objc func playerDidFinishPlaying() {
        nextTrack(isNextTrack: true)
    }
    
    @objc func trackViewPressed() {
        guard let tracks = tracks else { return }
        router?.showDetail(tracks: tracks, index: index)
    }
    
}
